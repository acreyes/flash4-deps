FROM ubuntu:20.04

ARG MYUSER

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
    g++ \
    gcc \
    gfortran \
    libz-dev \
    python2 \
    python3 \
    openssh-client \
    subversion \
    wget && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python2 /usr/local/bin/python


#########################
#                       #
#     INSTALL MPICH     #
#                       #
#########################
RUN wget -q -O - http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/mpich-3.3.2 && \
    ./configure && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/mpich-3.3.2


# ########################
# #                      #
# #     INSTALL HDF5     #
# #                      #
# ########################
RUN wget -q -O - https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/hdf5-1.12.0 && \
    ./configure --prefix=/usr/local --enable-parallel --enable-fortran && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hdf5-1.12.0


# # #########################
# # #                       #
# # #     INSTALL HYPRE     #
# # #                       #
# # #########################
RUN wget -q -O - https://github.com/hypre-space/hypre/archive/v2.19.0.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/hypre-2.19.0/src && \
    ./configure --prefix=/usr/local && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hypre-2.19.0

# RUN addgroup --system tester
# RUN adduser --system ${MYUSER}

# USER ${MYUSER}


# WORKDIR /home/${MYUSER}
# RUN ssh -o "StrictHostKeyChecking no" flash.rochester.edu
# RUN mkdir -p ~/.ssh
# RUN ssh-keyscan -H flash.rochester.edu >> ~/.ssh/known_hosts
# ENV SVN_SSH="ssh -i /mntssh/id_rsa"
# RUN echo $(ls /mnt) > /home/acreyes/out.txt
# # ENV SVN_CMD="svn co svn+ssh://${MYUSER}@flash.rochester.edu/home/svn/repos/flashTest/trunk /home/${MYUSER}/flashTest"
# ENV SVN_CMD="ls /mnt"
# RUN ${SVN_CMD} > ./svn.txt
# RUN ${SVN_CMD} > ./svncmd.txt

# RUN svn co svn+ssh://${MYUSER}@flash.rochester.edu/home/svn/repos/flashTest/trunk /home/${MYUSER}/flashTest

# ENTRYPOINT ["/mnt/gnu-mpich/runTest.sh"]
ENTRYPOINT ["/bin/bash"]

