#!/bin/bash

# parse arguments
MYUSER=$1
VM=$2
TESTFILE=$3
BRANCH=$4
BRANCH=$(echo ${BRANCH} | sed 's;\/;\\\/;')
VIEWARCH=$5

FLASHTEST_DIR=/home/${MYUSER}/flashTest
#configure ssh
#   add flash to known hosts and point ssh to user's id_rsa
mkdir -p ~/.ssh
echo -e "Host *\n    LogLevel QUIET\n    StrictHostKeyChecking no\n    IdentitiesOnly yes\n    IdentityFile /mnt/ssh/id_rsa\n    User ${MYUSER}" > ~/.ssh/config

# check out and configure flashTest
svn co svn+ssh://flash.rochester.edu/home/svn/repos/flashTest/trunk ${FLASHTEST_DIR}
cd ${FLASHTEST_DIR}

# specify the user, the branch, and the path in the view archive
# replace tester in config file with ${MYUSER}
sed "s/tester/${MYUSER}/g" ${FLASHTEST_DIR}/VMs/${VM}/config > ${FLASHTEST_DIR}/config
sed -i "s/@branchname/${BRANCH}/g" ${FLASHTEST_DIR}/config
sed -i "s/@view/${VIEWARCH}/g" ${FLASHTEST_DIR}/config

ln -f ${FLASHTEST_DIR}/VMs/${VM}/exeScript ./exeScript
# ln -s ${FLASHTEST_DIR}/TestInfoFiles/testComp.gnu-mpich.info ${FLASHTEST_DIR}/test.info
sed "s/gnu-ompi/${VM}/g" ${FLASHTEST_DIR}/${TESTFILE} > ${FLASHTEST_DIR}/test.info
head -1 ${FLASHTEST_DIR}/test.info

mkdir -p /home/${MYUSER}/FLASH4

#rsync the output directory from the volume to local
# mkdir -p /home/${MYUSER}/flashTest/output/${VM}
# mkdir -p /home/${MYUSER}/flashTest/localArchive/${VM}
# rsync -ap /outputdir/${VM}/output/ /home/${MYUSER}/flashTest/output/${VM}/
# rsync -ap /outputdir/${VM}/localArchive/ /home/${MYUSER}/flashTest/localArchive/${VM}/

## run flashTest!
${FLASHTEST_DIR}/flashTest.py -v -u -s ${VM} -f ${TESTFILE}
# ${FLASHTEST_DIR}/flashTest.py -v -u -s ${VM} UnitTest/UG/UnkVarIndexFirst/3d

##rsync output back to volume
# rsync -ap --delete /home/${MYUSER}/flashTest/output/${VM}/ /outputdir/${VM}/output/
# rsync -ap --delete /home/${MYUSER}/flashTest/localArchive/${VM}/ /outputdir/${VM}/localArchive/

