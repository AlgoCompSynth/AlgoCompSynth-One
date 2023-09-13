# Getting started

## Hardware
You will need an Windows 11 machine with an NVIDIA GPU. I test on an
Acer Nitro 5 with an GTX 1650 Ti and a Dell Aurora with an RTX 3090.
I do not have access to a 40 Series GPU and have no idea if this
will work on one. I also have no idea if it will work on older GPUs
than the GTX 1600 series.

## Software
You will need Windows 11 and Windows Subsystem for Linux 2 running
Ubuntu 22.04 LTS aka "jammy". You will also need the most recent
NVIDIA "game ready" drivers.

## Installation

1. Clone the repository.

    ```
    git clone https://github.com/AlgoCompSynth/AlgoCompSynth-One
    cd AlgoCompSynth-One/WSL-jammy
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

5. Review the log files in `WSL-jammy/Logs` for errors. If there
are any, open an issue at
<https://github.com/AlgoCompSynth/AlgoCompSynth-One/issues/new>.

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
Open and run the `cuSignal` test notebooks `E2E_Example_4GB.ipynb`
`E2E_Example_8GB.ipynb` and `E2E_Example_16GB.ipynb`. Depending on how
much RAM your computer and GPU have, they may not all run, but at least
the smallest one should.

These notebooks exercise both `cuSignal` and `PyTorch` on the CPU and
GPU, but they do not test `torchaudio`. If you get crashes on the
4 GB one, please open an issue at
<https://github.com/AlgoCompSynth/AlgoCompSynth-One/issues/new>.
