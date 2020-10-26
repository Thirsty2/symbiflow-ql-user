ARG PARENT_IMAGE="symbiflow-ql:latest"
FROM ${PARENT_IMAGE} as base

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt-get update && apt-get install -y \
    git \
    libusb-1.0-0 \
    python3-pip \
    usbutils \
    udev && \
    rm -rf /var/lib/apt/lists/*

FROM base as release-candidate

ARG USER=ic
ARG UID=1000
ARG GID=1000
RUN addgroup --gid ${GID} ${USER}
RUN adduser --uid ${UID} --gid ${GID} --gecos "" --disabled-password --shell /bin/bash ${USER} 
RUN usermod -a -G plugdev ${USER}
COPY 98-quickfeather.rules /etc/udev/rules.d/98-quickfeather.rules
USER ${USER}
WORKDIR /home/${USER}

# install programmer
RUN git clone --recursive https://github.com/QuickLogic-Corp/TinyFPGA-Programmer-Application.git
RUN pip3 install tinyfpgab pyserial
RUN alias qfprog="python3 ~/TinyFPGA-Programmer-Application/tinyfpga-programmer-gui.py"

SHELL [ "/bin/bash" ]
COPY conda-user.sh /scripts/conda-user.sh
#COPY ~/.bashrc /.bashrc
#ENV PATH=/home/ic/local/bin:$PATH
ENTRYPOINT [ "/scripts/conda-user.sh" ]

FROM release-candidate as symbiflow-ql-user

# Below are some example commands to build and run a docker container.
# From within the dockerfiles directory in a terminal window type:
#
# docker build . -t symbiflow-ql-user 
# 
# Or to base it on a particular parent image, try something like:
# 
# docker build --build-arg PARENT_IMAGE=symbiflow-ql:1.3.0 . -t symbiflow-ql-user:1.3.0
# 
# In a directory containing a symbiflow project:
# docker run --rm -v $(pwd):/home/ic symbiflow-ql-user
#
# The above will execute bash within the running container.  Any
# tools called thru bash will run within the container.
#
# You can run the container with an optional command, which it 
# passes to bash.  For instance to run 'ls' in the container:
#
# docker run --rm -v $(pwd):/home/ic symbiflow-ql-user ls
#
# docker run --privileged -it --rm --device-cgroup-rule "c 166:* rwm" --device-cgroup-rule "c 189:* rwm" -v /dev/bus:/dev/bus:ro -v /dev/serial:/dev/serial:ro -v $(pwd):/home/ic/work symbiflow-ql-user bash
# 