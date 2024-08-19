class DockerClient:
    def __init__(self, *args, **kwargs):
        self.api = APIClient(*args, **kwargs)
    
    @classmethod
    def from_env(cls, **kwargs):
        return cls()
    
from_env = DockerClient.from_env