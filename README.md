# Singularity Python

This repo contains singularity container definition files for py38 with CUDA/CuDNN support built on top of [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda). Clone and modify existing files to get different versions of python. To exclude CUDA/CuDNN support, use Ubuntu base images, e.g. `ubuntu:focal`.

Provides useful base containers for [Dev](https://github.com/saravanabalagi/singularity_dev) and [Pytorch](https://github.com/saravanabalagi/singularity_pytorch)

## Poetry Installation

[Poetry](https://python-poetry.org/) should be installed and configured locally to create in-project venvs

```sh
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
poetry config virtualenvs.in-project true
```

To use python present within a container and to create symlinks for convenience:

1. Start an instance `dev` that has python3 and python3-venv.
1. Run the included script [file](install_poetry.sh) to install poetry.

    ```sh
    sh ./install_poetry.sh
    ```
1. (Optional) Check comments and modify as necessary to use a different version of poetry.

## Licence

Please see attached [Licence](LICENCE)
