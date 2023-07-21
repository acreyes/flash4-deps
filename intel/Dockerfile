FROM ubuntu:20.04

ARG HDF5=1.12.0
ARG PNETCDF=1.12.3
ARG HYPRE=2.19.0


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
    less \
    libz-dev \
    python2 \
    python3 \
    openssh-client \
    subversion \
    m4 \
    wget && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python2 /usr/local/bin/python

# Install Intel
# Following steps by https://software.intel.com/content/www/us/en/develop/documentation/installation-guide-for-intel-oneapi-toolkits-linux/top/installation/install-using-package-managers/apt.html .
RUN cd /tmp && \
    wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB && \
    apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB && \
    rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB && \
    echo "deb https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list

# To save disk space, only install the required components, but not the whole intel-hpckit.
RUN apt-get update --allow-unauthenticated && \
    apt-get install -y --no-install-recommends \
        intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic \
        intel-oneapi-compiler-fortran \
        intel-oneapi-mkl-devel \
        intel-oneapi-mpi-devel 

SHELL ["/bin/bash", "-c"]
RUN source /opt/intel/oneapi/setvars.sh

ENV CC=mpiicc
ENV FC=mpiifort



########################
#                      #
#     INSTALL HDF5     #
#                      #
########################
RUN source /opt/intel/oneapi/setvars.sh && \
    wget -q -O - https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-${HDF5}/src/hdf5-${HDF5}.tar.gz | tar -C /tmp -xzf - && \
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
RUN source /opt/intel/oneapi/setvars.sh && \
    wget -q -O - https://parallel-netcdf.github.io/Release/pnetcdf-${PNETCDF}.tar.gz | tar -C /tmp -xzf - && \
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
RUN source /opt/intel/oneapi/setvars.sh && \
    wget -q -O - https://github.com/hypre-space/hypre/archive/refs/tags/v${HYPRE}.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/hypre-${HYPRE}/src && \
    ./configure --prefix=/usr/local && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hypre-${HYPRE}



# ENTRYPOINT ["source","/opt/intel/oneapi/setvars.sh"]
# ENTRYPOINT ["sh","/root/entrypont.sh"]
ENTRYPOINT ["/bin/bash"]

