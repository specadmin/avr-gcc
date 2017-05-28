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
apt-get install gcc g++ make zlib1g-dev m4


### libgmp
LIB_NAME="gmp"
LIB_VER=$GMP_VER
LIB_ARC="bz2"
echo "--> lib${LIB_NAME}"
if [ ! -f ${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC} ]; then
    $WGET_CMD ftp://gcc.gnu.org/pub/gcc/infrastructure/${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC}
fi
rm -rf ${LIB_NAME}-${LIB_VER}
if [ ! -f /usr/lib/lib${LIB_NAME}.so ]; then
    tar -xf ${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC}
    cd ${LIB_NAME}-${LIB_VER}
    ./configure --prefix=/usr
    make -j${NUM_THREADS} install
    cd ..
else
    echo "Already installed"
fi

### libmpfr
LIB_NAME="mpfr"
LIB_VER=$MPFR_VER
LIB_ARC="bz2"
echo "--> lib${LIB_NAME}"
if [ ! -f ${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC} ]; then
    $WGET_CMD ftp://gcc.gnu.org/pub/gcc/infrastructure/${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC}
fi
rm -rf ${LIB_NAME}-${LIB_VER}
if [ ! -f /usr/lib/lib${LIB_NAME}.so ]; then
    tar -xf ${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC}
    cd ${LIB_NAME}-${LIB_VER}
    ./configure --prefix=/usr
    make -j${NUM_THREADS} install
    cd ..
else
    echo "Already installed"
fi


### libmpc
LIB_NAME="mpc"
LIB_VER=$MPC_VER
LIB_ARC="gz"
echo "--> lib${LIB_NAME}"
if [ ! -f ${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC} ]; then
    $WGET_CMD ftp://gcc.gnu.org/pub/gcc/infrastructure/${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC}
fi
rm -rf ${LIB_NAME}-${LIB_VER}
if [ ! -f /usr/lib/lib${LIB_NAME}.so ]; then
    tar -xf ${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC}
    cd ${LIB_NAME}-${LIB_VER}
    ./configure --prefix=/usr
    make -j${NUM_THREADS} install
    cd ..
else
    echo "Already installed"
fi


### libisl
LIB_NAME="isl"
LIB_VER=$ISL_VER
LIB_ARC="bz2"
echo "--> lib${LIB_NAME}"
if [ ! -f ${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC} ]; then
    $WGET_CMD ftp://gcc.gnu.org/pub/gcc/infrastructure/${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC}
fi
rm -rf ${LIB_NAME}-${LIB_VER}
if [ ! -f /usr/lib/lib${LIB_NAME}.so ]; then
    tar -xf ${LIB_NAME}-${LIB_VER}.tar.${LIB_ARC}
    cd ${LIB_NAME}-${LIB_VER}
    ./configure --prefix=/usr
    make -j${NUM_THREADS} install
    cd ..
else
    echo "Already installed"
fi

