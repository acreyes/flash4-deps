#!/bin/bash
#
MYUSER=$1
INFOFILE=$2

source /opt/intel/oneapi/setvars.sh

/local/runTest.sh ${MYUSER} intel ${INFOFILE}


