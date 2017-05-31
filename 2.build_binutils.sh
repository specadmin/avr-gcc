#!/bin/bash


#PREFIX_DIR="${HOME}/avr-gcc/usr"
PREFIX_DIR="/usr"
NUM_THREADS=`nproc`

#BIN_VERSION="2.23"
BIN_VERSION="2.28"

##########################################

BIN_TAR="binutils-${BIN_VERSION}.tar.gz"
BIN_DIR="binutils-${BIN_VERSION}"
WGET_PARAMS="--passive-ftp --tries=3 -nc --progress=dot:binary"

WGET_CMD="wget ${WGET_PARAMS}"

if [ ! -f ${BIN_TAR} ]; then
echo "Fecthing binutils arhive"
$WGET_CMD ftp://ftp.gnu.org/gnu/binutils/${BIN_TAR}
fi

echo "Extracting files from BIN arhive"
rm -rf $BIN_DIR
tar -xf $BIN_TAR

echo "Applying binutils patches"
cd ${BIN_DIR}/binutils
patch < ../../patches/avr-size.patch
cd ../..

echo "Configuring BIN"
export LD_LIBRARY_PATH=/usr/lib 
mkdir $BIN_DIR/obj
cd $BIN_DIR/obj
../configure -v \
--target=avr \
--disable-nls \
--disable-werror \
--build=x86_64-linux-gnu \
--host=x86_64-linux-gnu \
--prefix=${PREFIX_DIR}/lib \
--infodir=${PREFIX_DIR}/share/info \
--mandir=${PREFIX_DIR}/share/man \
--bindir=${PREFIX_DIR}/bin \
--libexecdir=${PREFIX_DIR}/lib \
--libdir=${PREFIX_DIR}/lib 

make -j${NUM_THREADS}
make -j${NUM_THREADS} install-strip