To build symbiflow-ql-user run the build from the dockerfiles subdirectory:
```
cd dockerfiles
docker build . -t symbiflow-ql-user
```
The above assumes Docker can find an image called symbiflow-ql:latest.  

You can base the build on a particular image using the --build-arg PARENT_IMAGE param:
```
docker build --build-arg PARENT_IMAGE="symbiflow-ql:1.3.0" . -t symbiflow-ql-user
```
When you run this container, the entrypoint script activates conda,
installs the programming software, and runs an optional command 
inside the container.

Try this in the fpga_helloworldhw directory:
```
~/symbiflow-ql-user/fpga_helloworldhw$ ls
helloworldfpga.v  Makefile  quickfeather.pcf

~/symbiflow-ql-user/fpga_helloworldhw$ docker run -it --rm -v $(pwd):/home/ic/work symbiflow-ql-user bash

```
The bash session is running inside the container.  Change directories into work/fpga_hellowworldhw
and run make as a test:

cd work/fpga_helloworldhw
make 

The build directory contains the results:
```
~/symbiflow-ql-user/fpga_helloworldhw$ ls
build helloworldfpga.v  Makefile  quickfeather.pcf
```
To program the hardware, you may need to run the container privileged.  From the fpga_helloworldhw dir:
```
docker run --privileged -it --rm --device-cgroup-rule "c 166:* rwm" --device-cgroup-rule "c 189:* rwm" -v /dev/bus:/dev/bus:ro -v /dev/serial:/dev/serial:ro -v $(pwd):/home/ic/work symbiflow-ql-user bash
```