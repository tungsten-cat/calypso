

## Prerequisites
- Your favourite text editor, such as [VSCode](https://code.visualstudio.com/), [Sublime Text](https://www.sublimetext.com/), etc.
- [Docker](https://www.docker.com/) installed, for creating build environment inside a container.
- [QEMU](https://www.qemu.org/) or any other machine emulator for testing operating system.

## Setting up environment
Before we start, you should build an image for our build environment by running:
- `docker build build_env -t calypso-build_env`

Remember that instead of `build_env`, you can provide a name of any other folder, where you will put your Dockerfile, as well as instead of `calypso_build-env` you can give a title for your build environment image

> **Note**
> For detailed build environment configuration, you can check README of a [`calypso-build_env`](https://github.com/tungsten-cat/calypso-build_env) repo

