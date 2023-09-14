#!/bin/bash
#
MYUSER=$1

mkdir -p ~/.ssh
echo -e "Host *\n    LogLevel QUIET\n    StrictHostKeyChecking no\n    IdentitiesOnly yes\n    IdentityFile /mnt/ssh/id_rsa\n    User ${MYUSER}" > ~/.ssh/config

svn co svn+ssh://${MYUSER}@flash.rochester.edu/home/svn/repos/FLASH3/branches/flash4_py flash4
cd flash4

tools/scripts/pyFlash/pyFlashDoc.py
rsync -avp docs/designDocs/pyDocs/html/* ${MYUSER}@flash.rochester.edu:/data/asci2/site/flashcode/user_support/pyFlashDocs_py/
