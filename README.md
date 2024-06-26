AlgoCompSynth-One - Algorithmic Composition and Digital Sound Synthesis
================
M. Edward (Ed) Borasky

## Un-archiving - 3 May 2024

I’m unarchiving this and changing the deployment mechanism. It will be a
[Distrobox](https://distrobox.it/) container based on Arch Linux,
designed for use on [Fedora Atomic
Desktops](https://fedoraproject.org/atomic-desktops/) and [Universal
Blue](https://universal-blue.org/) Aurora and Bluefin.

If you’re into following along, this is happening in branch
`Arch-Distrobox`. Watch this space!

## Archiving - 31 March 2024

I am archiving the project for two reasons: 1. NVIDIA is no longer
enhancing JetPack 5, and the Orin hardware is just too expensive for me
at the moment, and 2. I have too many other projects to continue
maintaining this one.

There may be some GPU audio projects in the future, but they will not
use Jetson hardware.

## What is AlgoCompSynth-One?

AlgoCompSynth-One is a collection of tools for composing music and
synthesizing sound on systems with NVIDIA® GPUs. The current
implementation runs on the Jetson™ hardware, running JetPack 5.1.1 or
later, and Windows 11 with Ubuntu 22.04 LTS `jammy` running in Windows
Subsystem for Linux.

I test the JetPack version on an AGX Xavier with 16 GB of RAM, but it
should run on any Xavier or Orin device. It will not run on a device
that only supports JetPack 4.

I test the WSL version on a laptop with a GTX 1650 and a desktop with an
RTX 3090. It should run with any device supported by CUDA 11.8.

## What can it do?

AlgoCompSynth-One creates a
[Mamba](https://mamba.readthedocs.io/en/latest/index.html) virtual
environment and installs the remaining components in it. The user
specifies the name of the environment when the script creates it, with a
default of `acs-1`. This environment contains:

- [Python 3](https://www.python.org/) (version 3.8 on JetPack, 3.10 on
  Ubuntu 22.04 LTS),
- [JupyterLab](https://jupyter.org/),
- [PyTorch](https://pytorch.org/),
- [torchaudio](https://pytorch.org/audio/stable/index.html),
- [cuSignal](https://github.com/rapidsai/cusignal),
- [R](https://www.r-project.org/) (this is the version packaged by
  Mamba, currenty version 4.2.3 on JetPack, 4.3.1 on Ubuntu 22.04 LTS),
- [R package development tools](https://devtools.r-lib.org/),
- the [`reticulate`](https://rstudio.github.io/reticulate/) R - Python
  interface library,
- R audio libraries as described in [Sound Analysis and Synthesis with
  R](https://link.springer.com/book/10.1007/978-3-319-77647-7), and
- the [Quarto](https://quarto.org/) scientific and technical publishing
  system.

PyTorch and cuSignal are optimized for NVIDIA GPUs, enabling a variety
of digital signal processing and artificial intelligence applications,
including the emerging field of differentiable digital signal
processing.

The two main textbooks I recommend if you’re just getting started with
the software deployed in AlgoCompSynth-One are Sueur (2018) for the R
audio packages and Müller (2021) for the Python ones.

## How does it work?

AlgoCompSynth-One is a collection of installers. This has a number of
advantages:

- The field is moving rapidly, so you can always get the latest tested
  software,
- It avoids licensing issues with distributing binaries, and
- The source code is right there for you to examine and enhance.

The downside is that the components that need to be compiled on the
Jetson, `torchaudio`, `cupy`, and `cuSignal`, take a fair amount of time
to build. I have included logfiles of my builds on a Jetson AGX Xavier
so you can get an idea of what to expect for build times.

The builds only need to be done once unless you want to change versions.
On a Jetson, the Python wheels downloaded or built are cached, and the
install scripts will look for those first rather than doing a new build.

## Who is it for?

At the moment, it’s primarily for developers who need GPU speed for
digital signal processing or artificial intelligence. That’s a fairly
narrow audience given the kind of power today’s CPUs have, but there are
a number of audio analysis and synthesis approaches that can use GPU
power.

## How do I get started?

The short version is:

1.  Get a Jetson Developer Kit (Xavier or later) and install Jetpack
    5.1.1 or later,

    or

    get a Windows 11 machine with an NVIDIA GPU capable of supporting
    CUDA 11.8.

2.  Clone this repository.

3.  `cd` into `JetPack5` (Jetson) or `WSL-jammy` (Windows Subsystem for
    Linux Ubuntu 22.04 LTS) and follow the instructions on the
    `README.md` there.

## Roadmap

Now that the WSL port is done, I am stopping enhancements on the JetPack
version. The original motivation for this project was to build powerful
synthesizers on an inexpensive platform, the NVIDIA Jetson Nano. That
was before COVID-19, supply chain disruptions, and NVIDIA deploying the
Orin modules.

The Orin series devices are no doubt excellent, but they are intended
for applications at industrial scale and budgets. A hobbyist like myself
can now get better performance / dollar and payoff / effort ratios with
a 40 series laptop or desktop than with a Jetson Orin or Xavier device.

I plan to track `cuSignal` and `PyTorch` releases, and ensure that my R
music packages all work on the Jetson. But future enhancements will only
happen on the WSL version.

Finally, a word about other Linux distros. I believe this platform will
work out of the box on any `x86_64` Ubuntu 22.04 LTS machine with a CUDA
11.8 compatible GPU, but I don’t have one available to test. For other
distros, I don’t have the time to test them, but it should work if CUDA
11.8 and Mambaforge do, and you rewrite
`WSL-jammy/00linux-dependencies.sh` to install the required packages
from the distro.

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-müller2021fundamentals" class="csl-entry">

Müller, M. 2021. *Fundamentals of Music Processing: Using Python and
Jupyter Notebooks*. Springer International Publishing.

</div>

<div id="ref-sueur2018sound" class="csl-entry">

Sueur, J. 2018. *Sound Analysis and Synthesis with r*. Use r! Springer
International Publishing.

</div>

</div>
