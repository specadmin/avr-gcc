#!/bin/bash

NUM_THREADS=`nproc`

#GMP_VER="4.3.2"
GMP_VER="6.1.0"

#MPC_VER="0.8.1"
MPC_VER="1.0.3"

#MPFR_VER="2.4.2"
MPFR_VER="3.1.4"

#ISL_VER="0.15"
ISL_VER="0.16.1"

WGET_CMD="wget --passive-ftp --tries=3 -nc --progress=dot:binary"

echo "Building GCC infrastructure"
IFS_DIR="gcc-infrastructure"
mkdir ${IFS_DIR}
cd ${IFS_DIR}
apt-get install gcc g++ make zlib1g-dev libgmp-dev libmpfr-dev libmpc-dev
echo "--> libisl"
if [ ! -f isl-${ISL_VER}.tar.bz2 ]; then
$WGET_CMD ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-${ISL_VER}.tar.bz2
fi
rm -rf isl-${ISL_VER}
tar -xf isl-${ISL_VER}.tar.bz2
cd isl-${ISL_VER}
./configure --prefix=/usr
make -j${NUM_THREADS} install
cd ..
