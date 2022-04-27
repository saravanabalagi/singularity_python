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

## Tips

### 1. Long running Processes
- Install a terminal multiplexer such as `tmux` (or `screen`) on the host to run multiple sessions that can be attached and detached.

Although you could try other workarounds such as installing inside the container, IMHO installing `tmux` in the host is the best way so far, so just ask the admins to do it.

### 2. Building a Python Project using Singularity Containers

If you are simply using containers to run a long running process, say in a powerful shared machine **without sudo access**, then with singularity you get all the goodies such as reproducibility, isolation, integrity, etc. You only build the container once, and then run it whenever and whereever you need it to.

However, if you are building a new python project from scratch using singularity python containers, or modifying/debugging an existing python project, you would face the following issues:

- Containers can only be built on machines in which you have sudo access. Once built, the `sif` file has to be transferred to the machine in which it is going to run.
- Containers should be rebuilt everytime there is a change in your python package dependencies. For example, if you add a new small pip package `tqdm`, the entire container should be rebuilt, copied, and executed (or a new instance has to be created stopping the old one). Doing this multiple times quickly becomes a tiring process.
- You need to shell into containers or their instances to access executable files e.g. `python`. Oftentimes, it is impossible or very hard to seamlessly switch between the different environments: when you have some executables in the host, some in other containers, and you would want to interactively do things.
- No autocomplete support in most IDEs and text editors including `vscode` when using singularity containers. Using `vscode` notebooks would require manually starting a jupyter server and configuring vscode to use it as a remote kernel. While this might work, it's still a big inconvenience in a lot of scenarios.

The following tips are useful if you are using containers for prototyping or building your python project:

<details>
<summary>Access python (and other executables) from Host</summary>

To access `python` outside the singularity container, without `shell`ing into the container:

1. Start an instance from a python container, say with name `dev`
1. Add [module](https://gist.github.com/saravanabalagi/688e34150506759ea9d493fc913222d1) executable to host's `~/.local/bin`
1. Execute `module load python dev` on the host.
1. Voila, try `python --version` and `python -c 'Hello World'` on the host.

Note that this still accesses the `python` inside the instance. This works for other executables inside the container such as `cmake`, `poetry`, `ffmpeg`, etc. Since this still does switching, although conveniently, be informed that there are some caveats associated with this technique.

</details>

<details>
<summary>Autocomplete Support in VSCode</summary>

VScode running on the host machine will refuse to detect the poetry environment's interpreter. This is because the file `.venv/bin/python` is simply a symlink pointing to the container's system `python` the poetry used when installing python packages. The symlink would hence be invalid in the host (unless you have the same python version in the host). 

As a workaround, we can simply replace the symlink with the actual python executable.

```sh
$ singularity shell instance://dev
Singularity> pwd
/home/saravanabalagi/projects/python/my_project
Singularity> mv .venv/bin/python .venv/bin/python.bak
Singularity> cp /usr/bin/python .venv/bin/python
```

Voila, the suggestions will start working in `.py` files, and additionally, the vscode jupyter notebooks will start their server from the `.venv/bin/python` interpreter.

</details>

## Licence

Please see attached [Licence](LICENCE)
