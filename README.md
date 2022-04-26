# Singularity Python

This repo contains singularity container definition files for py38 with CUDA/CuDNN support built on top of [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda). Clone and modify existing files to get different versions of python. To exclude CUDA/CuDNN support, use Ubuntu base images, e.g. `ubuntu:focal`.

Provides useful base containers for [Dev](https://github.com/saravanabalagi/singularity_dev) and [Pytorch](https://github.com/saravanabalagi/singularity_pytorch)

## Poetry Installation

[Poetry](https://python-poetry.org/) should be installed and configured to create in-project venvs. 

1. Add poetry by building on top of `py38.sif` using [poetry.def](poetry.def).
1. Make sure to configure `in-project` virtualenvs, this will save a file on the host at `~/.config/pypoetry/config.toml`

    ```sh
    poetry config virtualenvs.in-project true
    ```

## Licence

Please see attached [Licence](LICENCE)
