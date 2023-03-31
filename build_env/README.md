## Setup build environment

To build an image for environment run the following command from the root folder of this project:
    
    docker build build_env -t calypso-build_env --build-arg BUILD_TARGET=x86_64-elf --build-arg USER_MAKE_JOBS=8
    
This command will work as is, but you may need to make some changes to make it match your system
- Instead of `calypso-build_env` you can specify any other name for your build environment. Later it will be used to launch the container with the build environment.
- In the `BUILD_TARGET` argument field, you should specify target platform for which you want to build cross compiler.
- The `USER_MAKE_JOBS` argument specifies how many jobs Make will run at the same time. If your CPU is old enough, you should decrease this value, and if you have more powerful CPU, you can increase this value. 