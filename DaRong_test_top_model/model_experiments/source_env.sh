#!/bin/sh


MYPATH=$(readlink -f "${BASH_SOURCE[0]}")
MYPATH=$(dirname "$MYPATH")

source $MYPATH/../model_platform/scripts/register_platform.sh

MYPATH=$(readlink -f "${BASH_SOURCE[0]}")
MYPATH=$(dirname "$MYPATH")

source $MYPATH/../inputdata/register_inputdata.sh

#module load intel/17.0.7
#module load mpi/intel/17.0.7

#module load netcdf/intel18/4.4.1-parallel
#module load LAPACK/3.8.0

