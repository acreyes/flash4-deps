#!/bin/bash
#
MYUSER=$1
VM=$2
TESTFILE=$3
BRANCH=$4
# BRANCH=$(echo ${BRANCH} | sed 's;\/;\\\/;')
VIEWARCH=$5

source /opt/intel/oneapi/setvars.sh

/local/runTest.sh ${MYUSER} ${VM} ${TESTFILE} ${BRANCH} ${VIEWARCH}


