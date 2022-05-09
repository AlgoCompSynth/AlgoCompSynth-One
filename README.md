# AlgoCompSynth-One - Algorithmic composition and digital sound synthesis

## What is it?

AlgoCompSynth-One is a collection of tools for composing music and synthesizing
sound on systems with NVIDIA® GPUs. The current implementation is focused on
the Jetson™ platform. However, a future release will run on Windows 11 with
Windows Subsystem for Linux.

## What can it do?

The current implementation creates a
[Mambaforge](https://github.com/conda-forge/miniforge) virtual environment
containing:

- [JupyterLab](https://jupyter.org/),
- [PyTorch](https://pytorch.org/),
- [torchaudio](https://pytorch.org/audio/stable/index.html), and
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

The downside is that, especially on the Jetson Nano, the components that need to
be compiled, `torchaudio` and `cuSignal`, take a fair amount of time to build.
I have included logfiles of my builds on a Jetson Nano, Xavier NX and AGX
Xavier so you can get an idea of what to expect for build times.

## Who is it for?

At the moment, it's primarily for developers with a Jetson Developer Kit. I am
planning a compatible version for Windows 11 with Windows Subsystem for Linux.

## How do I get started?

The short version is:

1. Get a Jetson Developer Kit.
2. Clone this repository.
3. At the terminal:

    ```
    cd AlgoCompSynth-One/JetPack
    ./00mambaforge.sh # sets up the Mambaforge package and environment manager
    ./05install.sh # installs the Python components
    ./10R-addons.sh # optional for R programmers
    ./20R-sound.sh # optional for R programmers
    ```

That will install everything.

## How do I test it?

```
cd AlgoCompSynth-One/JetPack
./start-jupyter-lab.sh
```

This will ask you to create a strong password, then start up a JupyterLab
server listening on `0.0.0.0:8888`. If you're on the Jetson GUI, you can browse
to `localhost:8888` and log in with the password you created. If you're on a
different machine on the same local area network, browse to
`the.jetson.ip.address:8888`.

Once you're logged in, there will be a list of folders on the right. Open the
`Notebooks` folder. You'll see three notebooks:

- `E2E_Example_4GB.ipynb` # 4 GB Nano
- `E2E_Example_8GB.ipynb` # 8 GB Xavier NX
- `E2E_Example_16GB.ipynb` # 16 GB or larger AGX Xavier
 
These are copies of the `cuSignal` end-to-end test notebook, which exercise
both `cuSignal` and `PyTorch`. Pick the one that matches the RAM in your
Jetson and run all the cells.

## What about JetPack 5.0 DP and the Orin?

I have tested this with the 8 GB Xavier NX running JetPack 5.0 developer preview and
everything works. In fact, it's slightly better because JetPack 5.0 is based on
Python 3.8 and CUDA 11.4, while JetPack 4.6.1 uses Python 3.6 and CUDA 10.2.

I do not currently have the budget for an AGX Orin Developer Kit, but if you
have one and run into issues with AlgoCompSynth-One on it, open an issue and
I'll try to help troubleshoot it.
