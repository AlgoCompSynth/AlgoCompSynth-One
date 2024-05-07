README
================
2024-05-03

## Licensing, etc.

The code is licensed MIT and the documentation is licensed CC0 (public
domain). I no longer make and distribute binary artifacts of any kind;
the additional effort level is just too much. I’ve licensed this very
permissively so that others so inclined can publish binaries.

## Requirements

You will need an `x86_64` aka `amd64` host machine with an NVIDIA GPU.
You will need Distrobox 1.7.1.0 or newer and all of its dependencies. I
develop on Bluefin DX NVIDIA “latest” (currently based on Fedora 40) but
it will work with Silverblue 40 with the NVIDIA drivers installed, the
equivalent Aurora distro, or any of the other Fedora 40 Atomic Desktops.
It will probably work on the Fedora 39 equivalents but I don’t test on
them any more.

## The infamous home directory

You will need to set aside a directory on your host machine for a
`$HOME` directory for the container. Although Distrobox mounts your host
home filesystem into the container, the software in this container may
not have the same convetions for using hidden files as your host system
or your other containers. As far as I know, there is no mechanism to
detecto ver-writing!

If you use your host home directory or another container’s home
directory for this container, things may break and you won’t know who
broke it, when or why. IMHO Distrobox needs to make independent
container home directories the default, with a warning if you use an
existing directory. I’ve built that into the scripts.
