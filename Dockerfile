FROM ubuntu:22.04

##########################
#                        #
#     INSTALL TZDATA     #
#                        #
##########################
RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata


#############################
#                           #
#     INSTALL COMPILERS     #
#                           #
#############################
RUN apt-get -y install \
    bash \
    build-essential \
    g++ \
    gcc \
    gdb \
    gfortran \
    git \
    libmpich-dev \
    libz-dev \
    mpich \
    openssh-client \
    python3 \
    subversion \
    sudo \
    wget \
    && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3 /usr/local/bin/python


########################
#                      #
#     INSTALL HDF5     #
#                      #
########################
RUN git clone https://github.com/HDFGroup/hdf5.git /tmp/hdf5 && \
    cd /tmp/hdf5 && \
    git checkout hdf5-1_13_1 && \
    ./configure --prefix=/usr/local --enable-parallel --enable-fortran && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hdf5


#########################
#                       #
#     INSTALL HYPRE     #
#                       #
#########################
RUN git clone https://github.com/hypre-space/hypre.git /tmp/hypre && \
    cd /tmp/hypre/src && \
    git checkout v2.25.0 && \
    ./configure --prefix=/usr/local && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hypre

RUN useradd -m -G sudo -s /bin/bash \
    -p $(perl -e 'print crypt($ARGV[0], "password")' 'flash') flash

USER flash

WORKDIR /home/flash

ENTRYPOINT ["/bin/bash"]

