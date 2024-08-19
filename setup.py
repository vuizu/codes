import os, sys, json, subprocess


config = {
    'nvidia': {
        'cuda': {
            'version': {
                'dash': '11-8',
                'short': '11.8',
                'long': '11.8.0'
            },
            'path': '/usr/local/cuda'
        },
        'cudnn': {
            'version': {
                'major': '8.7.0',
                'minor': '84-1'
            }
        },
        'nccl': {
            'path': '/usr/local/nccl',
            'version': '2.15.5-1+cuda11.8'
        },
        'tensorrt': {
            'version': {
                'major': '8.6.1',
                'minor': '6'
            },
            'path': '/usr/local/tensorrt'
        }
    },
    'tools': {
        'cmake': {
            'version': {
                'major': '3.20',
                'minor': '6'
            },
            'path': '/usr/local/cmake'
        }
    },
    'tvm': {
        'path': '/usr/local/tvm'  
    },
    'pytorch': {
        'torch': '2.3.0',
        'torchvision': '0.18.0',
        'torchaudio': '2.3.0',
        'idx_url': 'https://download.pytorch.org/whl/cu118'
    }
}

root_dir = os.path.abspath(os.path.dirname(__file__))
setup_dir = root_dir + "/setup"
file = setup_dir + "/Dockerfiles/Dockerfile.ubuntu2004"
resources_dir = setup_dir + "/resources"
image_name = "own/dev"


def check_and_install_docker() -> bool:
    try:
        import docker
        return True
    except ImportError:
        # or "python3 -m pip install --break-system-packages docker -i https://pypi.tuna.tsinghua.edu.cn/simple"
        subprocess.check_call([sys.executable, "-m", "pip", "install", "docker"])
        return False

def check_and_install_progress() -> bool:
    try:
        import alive_progress
        return True
    except ImportError:
        # or "python3 -m pip install --break-system-packages tqdm alive_progress -i https://pypi.tuna.tsinghua.edu.cn/simple"
        subprocess.check_call([sys.executable, "-m", "pip", "install", "alive_progress"])
        return False


def exec(cmd, shell=True, check=True, stderr=None, 
         stdout=None, capture_output=True, text=True):
    return subprocess.run(cmd, 
                          shell=shell, 
                          check=check, 
                          stderr=stderr, 
                          stdout=stdout, 
                          capture_output=capture_output, 
                          text=text)


def build_image(cli):
    pytorch = config['pytorch']
    tvm = config['tvm']

    cuda = config['nvidia']['cuda']
    cudnn = config['nvidia']['cudnn']
    nccl = config['nvidia']['nccl']
    tr = config['nvidia']['tensorrt']

    cmake = config['tools']['cmake']

    try:
        cli.images.get(image_name)
        print("image already exists.")
    except ImageNotFound:
        print("building image...")
        # docker build -t own/dev -f file resources_dir

        # image, logs = cli.images.build(...)
        for line in alive_it(cli.api.build(
            # -t
            tag=image_name,
            # --build-arg
            buildargs={
               'TORCH_VERSION': pytorch['torch'],
               'TORCHVISION_VERSION': pytorch['torchvision'],
               'TORCHAUDIO_VERSION': pytorch['torchaudio'],
               'IDX_URL': pytorch['idx_url'],

               'CUDA_INSTALL_PATH': cuda['path'],
               'CUDA_DASH_VERSION': cuda['version']['dash'],
               'CUDNN_VERSION': f'{cudnn['version']['major']}.{cudnn['version']['minor']}+cuda{cuda['version']['short']}',
               'NCCL_VERSION': nccl['version'],

               'TENSORRT_INSTALL_PATH': tr['path'],
               'TENSORRT_MAJOR_VERSION': tr['version']['major'],
               'TENSORRT_MINOR_VERSION': tr['version']['minor'],
               'CUDA_SHORT_VERSION': cuda['version']['short'],
               # 'PY_MINOR_VERSION': f'{sys.version_info.minor}',
               'PY_MINOR_VERSION': '8',

               'CMAKE_INSTALL_PATH': cmake['path'],
               'CMAKE_MAJOR_VERSION': cmake['version']['major'],
               'CMAKE_MINOR_VERSION': cmake['version']['minor'],
               
               # 'TVM_INSTALL_PATH': tvm['path']
            },
            rm=True,
            dockerfile=file,
            path=resources_dir
        )):
            json_obj = json.loads(line.decode('utf-8'))
            log = json_obj.get('stream', json_obj.get('aux'))
            print(log)
            if log is not None and any(kw in log for kw in ["ERROR", "FAILED"]):
                print("build failure!!!")
                sys.exit(-1)

        print("build finished...")
    except Exception:
        sys.exit(1) 


def create_container(cli):
    obj = None
    try:
        obj = cli.containers.get('dev')
        print("container already exists.")
    except NotFound:
        build_image(cli)
        print("creating container...")
        obj = cli.containers.run(
            # -d 
            detach=True,
            # -p
            ports={ '22/tcp': ('0.0.0.0', 6666) },
            # -v 
            volumes=[f"{root_dir}/cxx:/root/cxx"],
            # --gpus all
            device_requests=[
                DeviceRequest(
                    driver='nvidia',
                    count=-1,
                    capabilities=[['gpu']]
                )
            ],
            # --memory 20g
            mem_limit='20g',
            # --memory-swap 20g
            memswap_limit='20g',
            # --cap-add CAP_SYS_PTRACE
            cap_add=['CAP_SYS_PTRACE'],
            # --security-opt seccomp=unconfined
            security_opt=["seccomp=unconfined"],
            # --name dev
            name='dev',
            # own/dev
            image=image_name)
        print("container running...")
    except Exception:
        sys.exit(2)
    return obj


def delete_all(ALL=False):
    exec("docker rm -f dev")
    print("dev container deleted...")
    if ALL:
        exec("docker rmi own/dev")
        print("own/dev image deleted...")


if __name__ == "__main__":
    if check_and_install_docker() and check_and_install_progress():
        import docker
        from docker.types import DeviceRequest
        from docker.errors import ImageNotFound, NotFound
        
        from alive_progress import alive_it

        cli = docker.from_env()

        # build_image(cli)
        obj = create_container(cli)

        # delete_all(True)