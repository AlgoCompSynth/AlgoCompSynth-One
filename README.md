# AlgoCompSynth-One - Algorithmic composition and digital sound synthesis

## What is it?

AlgoCompSynth-One is a collection of tools for composing music and synthesizing
sound on systems with NVIDIA® GPUs. The current implementation runs on
the Jetson™ Xavier or Orin hardware, running Jetpack 5.1.1 or later, and
Windows 11 with Ubuntu 22.04 LTS `jammy` running in Windows Subsystem for Linux.

I don't currently have an Orin device to test on. The AGX Xavier development
kit I have is sufficient for my needs, but I might get an Orin device in late
late fall or early winter 2023.

## What can it do?

AlgoCompSynth-One creates a
[Mambaforge](https://github.com/conda-forge/miniforge) virtual environment
called `r-reticulate` containing:

- [JupyterLab](https://jupyter.org/),
- [PyTorch](https://pytorch.org/),
- [torchaudio](https://pytorch.org/audio/stable/index.html),
- [cuSignal](https://github.com/rapidsai/cusignal).

PyTorch and cuSignal are optimized for NVIDIA GPUs, enabling a variety
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

The downside is that the components that need to be compiled on the Jetson,
`torchaudio`, `cupy`, and `cuSignal`, take a fair amount of time to
build. I have included logfiles of my builds on a Jetson AGX Xavier so you
can get an idea of what to expect for build times.

The builds only need to be done once unless you want to change versions.
The installers create a virtual desktop inside this repository. The Python
wheels downloaded or built are cached in `AlgoCompSynth-One/JetPack5/Wheels`,
and the install scripts will look for those first rather than doing a new
build.

## Who is it for?

At the moment, it's primarily for developers who need GPU speed for digital
signal processing or artificial intelligence. That's a fairly narrow audience
given the kind of power today's CPUs have, but I can think of some composition
and synthesis approaches that can use GPU power.

## How do I get started?

The short version is:

1. Get a Jetson Developer Kit (Xavier or later) and install Jetpack 5.1.1 or later,

    or

    get a Windows 11 machine with an NVIDIA GPU capable of supporting CUDA 11.8.

    I don't have an RTX 40xx to test on, and I don't know if this code will work
on one without any changes. I test on a Jetson AGX Xavier, a laptop with a GTX
1650 Ti and a desktop with an RTX 3090.

2. Clone this repository.

3. `cd` into `JetPack5` (Jetson)  or `WSL-jammy` (Windows Subsystem for Linux
Ubuntu 22.04 LTS) and follow the instructions on the `README.md` there.

## Roadmap

I'm not sure where I want to take this, now that the WSL / jammy port is done.
The original motivation for this, powerful synthesizers on an inexpensive device
(original Jetson Nano Developer Kit) has largely dissipated.

So my focus shifted to the musical applications of deep learning, and for those,
the price-performance ratio of consumer gaming GPUs like the RTX 20, 30 and now
40 series is ***much*** better than the new Jetson Orin line. The effort-to-payoff
ratio is much better as well - the workhorses, `PyTorch` and `cuSignal`, are
available as binaries via `mamba install`.

So at the moment, the plan is to put the JetPack 5 version into a maintenance mode.
I plan to track `cuSignal` and `PyTorch` releases, and ensure that my R music
packages all work on the Jetson, but I don't see the point in enhancing that
version.
