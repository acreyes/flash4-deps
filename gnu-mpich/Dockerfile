FROM ubuntu:20.04

ARG MPICH
ARG HDF5
ARG PNETCDF
ARG HYPRE


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
RUN apt-get update && apt-get -y install \
    bash \
    build-essential \
    cmake \
    less \
    g++ \
    gcc \
    gfortran \
    liblapack-dev \
    libz-dev \
    python2 \
    python3-pip \
    openssh-client \
    subversion \
    m4 \
    wget && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python2 /usr/local/bin/python

# PYBIND11
RUN pip3 install pybind11

#########################
#                       #
#     INSTALL MPICH     #
#                       #
#########################
RUN wget -q -O - http://www.mpich.org/static/downloads/${MPICH}/mpich-${MPICH}.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/mpich-${MPICH} && \
    ./configure && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/mpich-${MPICH}


# ########################
# #                      #
# #     INSTALL HDF5     #
# #                      #
# ########################
RUN wget -q -O - https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-${HDF5}/src/hdf5-${HDF5}.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/hdf5-${HDF5} && \
    ./configure --prefix=/usr/local --enable-parallel --enable-fortran && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hdf5-${HDF5}

# ###########################
# #                         #
# #     INSTALL PNETCDF     #
# #                         #
# ###########################
RUN wget -q -O - https://parallel-netcdf.github.io/Release/pnetcdf-${PNETCDF}.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/pnetcdf-${PNETCDF} && \
    ./configure --prefix=/usr/local && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/pnetcdf-${PNETCDF}


# # #########################
# # #                       #
# # #     INSTALL HYPRE     #
# # #                       #
# # #########################
RUN wget -q -O - https://github.com/hypre-space/hypre/archive/v${HYPRE}.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/hypre-${HYPRE}/src && \
    ./configure --prefix=/usr/local && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hypre-${HYPRE}

ENTRYPOINT ["/bin/bash"]

