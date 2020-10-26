To build symbiflow-ql-make with an entrypoint that runs make, 
run the build from the dockerfiles subdirectory:
```
cd dockerfiles
docker build . -t symbiflow-ql-make
```
The above assumes Docker can find an image called symbiflow-ql:latest.  

You can base the build on a particular image using the --build-arg PARENT_IMAGE param:
```
docker build --build-arg PARENT_IMAGE="symbiflow-ql:1.3.0" . -t symbiflow-ql-make
```
When you run this container, it automatically invokes make in the current directory.
The make tool, and all of the tools it calls, run inside the container.

The -v (volume) command maps the current directory on your system to
the /home/ic directory inside the container.

Try this in the fpga_helloworldhw directory:
```
~/symbiflow-ql-make/fpga_helloworldhw$ ls
helloworldfpga.v  Makefile  quickfeather.pcf

~/symbiflow-ql-make/fpga_helloworldhw$ docker run -v $(pwd):/home/ic symbiflow-ql-make

  each build output line begins with 'cd build && ...' and is ommitted for brevity
```
The build directory contains the results:
```
~/symbiflow-ql-make/fpga_helloworldhw$ ls
build helloworldfpga.v  Makefile  quickfeather.pcf
```

Run the container again, passing the clean command to the make entrypoint:

```
~/symbiflow-ql-make/fpga_helloworldhw$ docker run -v $(pwd):/home/ic symbiflow-ql-make clean
rm -rf build
~/symbiflow-ql-make/fpga_helloworldhw$ ls
helloworldfpga.v  Makefile  quickfeather.pcf
```
