import os
import sys
import json
import subprocess

# git config --global user.email "thq23333@gmail.com"
# git config --global user.name "ntwd"

root_dir = os.path.abspath(os.path.dirname(__file__))
setup_dir = root_dir + "/setup"
file = setup_dir + "/Dockerfiles/Dockerfile.ubuntu2004"
resources_dir = setup_dir + "/resources"
image_name = "own/dev"
# image_name = "test"


def check_and_install_docker() -> bool:
    try:
        import docker
        return True
    except ImportError:
        # or "python3 -m pip install --break-system-packages docker -i https://pypi.tuna.tsinghua.edu.cn/simple"
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-i", "https://pypi.tuna.tsinghua.edu.cn/simple", "docker"])
        return False

def check_and_install_progress() -> bool:
    try:
        import alive_progress
        return True
    except ImportError:
        # or "python3 -m pip install --break-system-packages tqdm alive_progress -i https://pypi.tuna.tsinghua.edu.cn/simple"
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-i", "https://pypi.tuna.tsinghua.edu.cn/simple", "alive_progress"])
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
    """
        docker build -t own/dev -f ./Dockerfiles/Dockerfile.ubuntu2004 resouces
    """
    try:
        cli.images.get(image_name)
        print("image already exists.")
    except ImageNotFound:
        print("building image...")
        # image, logs = cli.images.build(...)
        for line in alive_it(cli.api.build(
            # -t
            tag=image_name,
            # --build-arg
            buildargs={
            },
            rm=True,
            dockerfile=file,
            path=resources_dir
        )):
            json_obj = json.loads(line.decode('utf-8'))
            log = json_obj.get('stream', json_obj.get('aux'))
            print(log)
            if log is not None and any(kw in log for kw in ["ERROR", "FAILED", "fatal"]):
                print("build failure!!!")
                sys.exit(-1)

        print("build finished...")
    except Exception:
        sys.exit(1) 


def create_container(cli):
    """
        docker run \
                -d \
                -p 6666:22 \
                -p 8888:8888 \
                -v $(pwd)/src:/root/src \
                --gpus all \
                --memory 20G \
                --memory-swap 20G \
                --cap-add CAP_SYS_PTRACE \
                --security-opt seccomp=unconfined \
                --name dev \
                own/dev
    """
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
            ports={ '22/tcp'  : ('0.0.0.0', 6666),
                    '8888/tcp': ('0.0.0.0', 8888) },
            # -v 
            volumes=[f"{root_dir}/src:/root/src"],
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
    # apt install python3-venv && python3 -m venv venv && source venv/bin/activate
    if check_and_install_docker() and check_and_install_progress():
        import docker
        from docker.types import DeviceRequest
        from docker.errors import ImageNotFound, NotFound
        
        from alive_progress import alive_it

        cli = docker.from_env()

        # build_image(cli)
        obj = create_container(cli)

        # delete_all(True)