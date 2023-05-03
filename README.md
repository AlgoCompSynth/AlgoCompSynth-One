# AlgoCompSynth-One - Algorithmic composition and digital sound synthesis

## What is it?

AlgoCompSynth-One is a collection of tools for composing music and synthesizing
sound on systems with NVIDIA® GPUs. The current implementation is focused on
the Jetson™ Xavier or Orin hardware, running Jetpack 5.1.1 or later.
However, a future release will run on Windows 11 with Windows Subsystem for Linux.

The previous version supported Jetpack 4 and would run on the original Nano. I
can't support that any more. Jetpack 4 is based on Ubuntu `bionic` and Python 3.6,
which are no longer supported, and there aren't convenient binaries for recent
versions of PyTorch. NVIDIA have moved on, and so have I.

I don't currently have an Orin device to test on. The AGX Xavier development
kit I have is sufficient for my needs, but I might get an Orin Nano
development kit in the late summer or fall. My priorities are

1. Clean up everything on Jetpack 5.1.1 / strip out the legacy Jetpack 4 support.
2. Move the R functionality into the base install.
3. Build the WSL Ubuntu `jammy` version.

## What can it do?

The current implementation creates a
[Mambaforge](https://github.com/conda-forge/miniforge) virtual environment
called `r-reticulate` containing:

- [JupyterLab](https://jupyter.org/),
- [PyTorch](https://pytorch.org/),
- [torchaudio](https://pytorch.org/audio/stable/index.html),
- [torchvison](https://pytorch.org/vision/stable/index.html), and
- [cuSignal](https://github.com/rapidsai/cusignal).

The above tools are all optimized for the Jetson platform, enabling a variety
of digital signal processing and artificial intelligence applications,
including the emerging field of differentiable digital signal processing.

The above capabilities are for the most part Python-based. As you probably know,
I'm mostly an R programmer. So I've provided installers for the R Jupyter
kernel, R packages that interface with Python, R package development tools, and
R sound processing packages.

## How does it work?

AlgoCompSynth-One is a collection of installers. This has a number of
advantages:

- The field is moving rapidly, so you can always get the latest tested software,
- It avoids licensing issues with distributing binaries, and
- The source code is right there for you to examine and enhance.

The downside is that the components that need to be compiled, `torchaudio`,
`torchvision`, `cupy`, and `cuSignal`, take a fair amount of time to
build. I have included logfiles of my builds on a Jetson AGX Xavier so you
can get an idea of what to expect for build times.

The builds only need to be done once unless you want to change versions.
The installers create a virtual desktop inside this repository. The Python
wheels downloaded or built are cached in `AlgoCompSynth-One/JetPack5/Wheels`,
and the install scripts will look for those first rather than doing a new
build.

## Who is it for?

At the moment, it's primarily for developers with a Jetson Xavier or Orin
system. I am planning a compatible version for Windows 11 with
Windows Subsystem for Linux running Ubuntu 22.04 LTS aka `jammy`.

## How do I get started?

The short version is:

1. Get a Jetson Developer Kit (Xavier or later) and install Jetpack 5.1.1 or later.
2. Clone this repository.
3. At the terminal:

    ```
    cd AlgoCompSynth-One/JetPack5
    ./00command-line.sh # installs command line conveniences and Linux dependencies
    ./05mambaforge.sh # sets up the Mambaforge package and environment manager
    ./10install.sh # installs the Python and R components
    ```

That will install everything.

## How do I test it?

```
cd AlgoCompSynth-One/JetPack5
./start-jupyter-lab.sh
```

This will ask you to create a strong password, then start up a JupyterLab
server listening on `0.0.0.0:8888`. If you're on the Jetson GUI, you can browse
to `localhost:8888` and log in with the password you created. If you're on a
different machine on the same local area network, browse to
`the.jetson.ip.address:8888`.

Once you're logged in, there will be a list of folders on the left. Open the
`Notebooks` folder. You'll see two notebooks:

- `E2E_Example_8GB.ipynb` # 8 GB Xavier or Orin
- `E2E_Example_16GB.ipynb` # 16 GB or larger Xavier or Orin
 
These are copies of the `cuSignal` end-to-end test notebook, which exercise
both `cuSignal` and `PyTorch`. Pick the one that matches the RAM in your
Jetson and run all the cells.
