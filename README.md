

## Prerequisites
- Your favourite text editor, such as [VSCode](https://code.visualstudio.com/), [Sublime Text](https://www.sublimetext.com/), etc.
- [Docker](https://www.docker.com/) installed, for creating build environment inside a container.
- [QEMU](https://www.qemu.org/) or any other machine emulator for testing operating system.

## Setting up environment
Before we start, you should build an image for our build environment by running:
- `docker build build_env -t calypso-build_env`
> **Note**
> Instead of `build_env` you can provide a name of a folder, containing your Dockerfile

> **Note**
> Instead of `calypso_build-env` you can provide a title for your building environment image