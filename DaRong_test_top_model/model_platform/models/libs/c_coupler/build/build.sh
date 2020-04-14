#!/bin/bash
CPPFLAGS="-traditional-cpp -DLINUX -DNO_SHR_VMATH -DMPI_P"
NETCDFINC="  -g -I/opt/netCDF-intel13-without-hdf5/include "
NETCDFLIB="  -L/opt/netCDF-intel13-without-hdf5/lib -lnetcdff -lnetcdf "
MPIINC="  -I/opt/intel/impi/3.2.0.011/include64 "
MPILIB="  -L/opt/intel/impi/3.2.0.011/lib64 "

export CC=mpiicc
export CXX=mpiicpc
export FC=mpiifort
#export CPP=/usr/bin/cpp
#export CFLAGS="-O2 -DFORTRANUNDERSCORE -g"
export CFLAGS=" -DFORTRANUNDERSCORE -g"
#export CXXFLAGS="-O2 -c -DFORTRANUNDERSCORE -g"
export CXXFLAGS=" -O0 -c -DFORTRANUNDERSCORE -traceback -g"
export FFLAGS="-g -free -O0 -c -i4  -r8 -convert big_endian -assume byterecl -fp-model precise"
export INCLDIR=" ${NETCDFINC} ${MPIINC} "
export SLIBS=" ${NETCDFLIB} ${MPILIB} "
export CPPFLAGS="${CPPFLAGS} ${INCLDIR} "

make -j 8
