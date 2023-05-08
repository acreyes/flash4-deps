#!/bin/bash

# parse arguments
MYUSER=$1
VM=$2
FLASHTEST_DIR=/home/${MYUSER}/flashTest
#configure ssh
#   add flash to known hosts and point ssh to user's id_rsa
mkdir -p ~/.ssh
ssh-keyscan -H flash.rochester.edu >> ~/.ssh/known_hosts
export SVN_SSH="ssh -i /mnt/ssh/id_rsa"

# check out and configure flashTest
svn co svn+ssh://${MYUSER}@flash.rochester.edu/home/svn/repos/flashTest/trunk ${FLASHTEST_DIR}
cd ${FLASHTEST_DIR}
# replace tester in config file with ${MYUSER}
sed "s/tester/${MYUSER}/g" ${FLASHTEST_DIR}/VMs/${VM}/config > ${FLASHTEST_DIR}/config
ln -s ${FLASHTEST_DIR}/VMs/${VM}/exeScript ./exeScript
ln -s ${FLASHTEST_DIR}/TestInfoFiles/testComp.gnu-mpich.info ${FLASHTEST_DIR}/test.info
mkdir -p /home/${MYUSER}/FLASH4

# run flashTest!
${FLASHTEST_DIR}/flashTest.py -v -u -s ${VM} -f TestFiles/lahey-mpi2/quickTests

