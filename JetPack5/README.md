# Getting started

## Hardware
You will need an NVIDIA Jetson Xavier NX, AGX Xavier or Orin. Older
Jetsons are no longer supported.

## Software
You will need Jetpack 5.1.1 or later.

## Installation

1. Clone the repository.

    ```
    git clone https://github.com/AlgoCompSynth/AlgoCompSynth-One
    cd AlgoCompSynth-One/JetPack5
    ```

2. Install required Ubuntu packages. You will need to authenticate
via `sudo`.

    ```
    ./00ubuntu-packages.sh
    ```

3. Install `mambaforge`. This will ask you where you want to install
`mambaforge`. Unless you have a strong reason for another location,
the default is fine.

    ```
    ./05mambaforge.sh
    ```

4. Create the `r-reticulate` Mamba virtual environment and install
the AlgoCompSynth-One packages.

    ```
    ./10r-reticulate.sh
    ```

    This will take quite a while to run. It first installs a number
of Mamba packages and PyTorch. Then it compiles `torchaudio` from
source. After that, it compiles `cupy` and `cuSignal` from source.

    If you're running it from a remote machine via `ssh`, it's 
possible the connection will time out and the job will fail. In this
case, do

    ```
    /usr/bin/time ./10r-reticulate.sh > Logs/10r-reticulate.log 2>&1 &
    top
    ```

    The `top` will keep the connection open until the job finishes.
You can monitor its progress by opening a second `ssh` window and
doing `tail -f` on the logfiles in `Logs`.

For a reference point on build times, see the archived logfiles
in `JetPack5/AGX-Xavier-Logs`, which are timestamped from my
most recent build on a 16 GB AGX Xavier. The total time on a clean
system was 53 minutes.

5. Review the log files in `JetPack5/Logs` for errors. If there
are any, open an issue at
<https://github.com/AlgoCompSynth/AlgoCompSynth-One/issues/new>.
You can ignore errors in the `cupy` compile; the build process
generates errors while discovering the machine configuration
but completes and installs `cupy`.

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

4. Browse to `http://localhost:8888/lab` and enter the password you
defined above. If you're accessing the Jetson remotely, use the IP
address of the Jetson instead of `localhost`. You are now in the
AlgoCompSynth-One virtual desktop.

5. In the file manager panel on the left, open the `Notebooks` folder.
Open and run one of the `cuSignal` test notebooks `E2E_Example_4GB.ipynb`
`E2E_Example_8GB.ipynb`, or `E2E_Example_16GB.ipynb`.

   The numbers in the notebook names refer to RAM capacity of the Jetson.
Run one that will fit. The larger ones might run, but if they do,
they will spend excessive time shuttling data back and forth between
the CPU and GPU.

    These notebooks exercise both `cuSignal` and `PyTorch` on the CPU and
GPU, but they do not test `torchaudio`. If you get crashes on the
4 GB one, please open an issue at
<https://github.com/AlgoCompSynth/AlgoCompSynth-One/issues/new>.

## Using from the command line
You can use the `r-reticulate` environment from the command line. Both
`bash` and `zsh` are supported. Two aliases are provided.
`r-reticulate` activates the `r-reticulate` environment, and `deac`
deactivates whatever environment you are currently in.

Example:

    ```
    r-reticulate
    python Scripts/test-torchaudio.py # runs the `torchaudio` test

    R
    > demo(graphics)
    > quit()
    deac
    ```
