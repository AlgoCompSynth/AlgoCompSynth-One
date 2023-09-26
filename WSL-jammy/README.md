# Getting started

## Hardware
You will need an Windows 11 machine with an NVIDIA GPU. The GPU should
have at least 4 GB of RAM to run the test notebooks. I test on an
Acer Nitro 5 with an GTX 1650 Ti and a Dell Aurora with an RTX 3090.
I do not have access to a 40 Series GPU and have no idea if this
will work on one. I also have no idea if it will work on older GPUs
than the GTX 1600 series.

## Software
You will need Windows 11 and Windows Subsystem for Linux 2 running
Ubuntu 22.04 LTS aka "jammy". You will also need the most recent
NVIDIA "game ready" drivers on Windows. See [CUDA on WSL User
Guide](https://docs.nvidia.com/cuda/wsl-user-guide/index.html) for background.

## Installation

1. Clone the repository.

    ```
    git clone https://github.com/AlgoCompSynth/AlgoCompSynth-One
    cd AlgoCompSynth-One/WSL-jammy
    ```

2. Install required Linux dependencies. You will need to authenticate
via `sudo`.

    ```
    ./00ubuntu-packages.sh
    ```

3. Install `mambaforge`. This will search for an existing `mambaforge`
and exit if it finds one. Otherwise, it will ask you where you
want to install `mambaforge`. Unless you have a strong reason for
another location, use the default `$HOME/mambaforge`.

    ```
    ./05mambaforge.sh
    ```

4. Create the Mamba virtual environment.

    ```
    ./10mamba-env.sh
    ```

    If there is an existing Mamba virtual environment, the script
    will use it. Otherwise, the script will prompt for a Mamba
    environment name to create. The default is `acs-1`, but you
    can use any name.

    The script adds aliases to `.bash_aliases` and, if it exists,
    to `.zshrc`, aliasing `deac` to `mamba deactivate` and aliasing the
    enviroment name to `mamba activate $MAMBA_ENV_NAME`. So you
    will need to make sure the environment name does not conflict
    with another alias you have defined.

5. Install the packages into the virtual environment.

    ```
    ./20packages.sh
    ```

    This will install `PyTorch`, `torchaudio`, the `rTorch` R library
    package and `cuSignal`.

6. Review the log files in `WSL-jammy/Logs` for errors. If there
are any, open an issue at
<https://github.com/AlgoCompSynth/AlgoCompSynth-One/issues/new>.

The list of all the Mamba packages installed in the `r-reticulate`
environment can be found in `Logs/Mamba-packages.log`. For the
R packages, see `Logs/R-packages.log`.

## Testing

1. If you're a `vim` user, execute the script

    ```
    ./set-vim-background.sh
    ```

    for light or dark background. If you've already done that, you
can skip this step.

2. If you're a `git` user, edit and execute the script

    ```
    edit-me-then-run-4-git-config.sh
    ```

3. Start the JupyterLab server.

    ```
    ./start-jupyter-lab.sh
    ```

    This will generate a configuration file and ask you to enter a
password. Then it will start the server listening on `0.0.0.0:8888`.

4. Browse to `localhost:8888` and enter the password you defined above.
You are now in the AlgoCompSynth-One virtual desktop.

5. In the file manager panel on the left, open the `Notebooks` folder.
Open and run one of the `cuSignal` test notebooks `E2E_Example_4GB.ipynb`
`E2E_Example_8GB.ipynb`, or `E2E_Example_16GB.ipynb`.

   The numbers in the notebook names refer to RAM capacity of the ***GPU***.
Check your GPU RAM capacity with `nvidia-smi` and run one that will fit. The
larger ones might run, but if they do, they will spend excessive time
shuttling data back and forth between the CPU and GPU.

    These notebooks exercise both `cuSignal` and `PyTorch` on the CPU and
GPU, but they do not test `torchaudio`. If you get crashes on the
4 GB one, please open an issue at
<https://github.com/AlgoCompSynth/AlgoCompSynth-One/issues/new>.

## Using from the command line
You can use the Mamba environment from the command line. Both
`bash` and `zsh` are supported. Two aliases are provided.
`deac` deactivates whatever environment you are currently in,
and the environment name itself is aliased to `mamba activate
$MAMBA_ENV_NAME`.

Example:

    ```
    # Mamba environment is 'acs-1'
    acs-1
    python Scripts/test-torchaudio.py # runs the `torchaudio` test

    R
    > demo(graphics)
    > quit()
    deac
    ```
