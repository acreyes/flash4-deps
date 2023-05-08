#!/bin/bash

# parse arguments
MYUSER=$1
VM=$2
TESTFILE=$3

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

#rsync the output directory from the volume to local
mkdir -p /home/${MYUSER}/flashTest/output/${VM}
rsync -avp /outputdir/${VM}/ /home/${MYUSER}/flashTest/output/${VM}/

# run flashTest!
${FLASHTEST_DIR}/flashTest.py -v -u -s ${VM} -f ${TESTFILE}

#rsync output back to volume
rsync -avp /home/${MYUSER}/flashTest/output/${VM}/ /outputdir/${VM}/

