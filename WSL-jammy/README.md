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

    git clone https://github.com/AlgoCompSynth/AlgoCompSynth-One
    cd AlgoCompSynth-One/WSL-jammy

2. Install required Ubuntu packages. You will need to authenticate
via `sudo`.

    ./00ubuntu-packages.sh

3. Install `mambaforge`. This will ask you where you want to install
`mambaforge`. Unless you have a strong reason for another location,
the default is fine.

    ./05mambaforge.sh

4. Create the `r-reticulate` Mamba virtual environment and install
the AlgoCompSynth-One packages.

    ./10r-reticulate.sh

5. Review the log files in `WSL-jammy/Logs` for errors. If there
are any, open an issue at
<https://github.com/AlgoCompSynth/AlgoCompSynth-One/issues/new>.

## Testing
