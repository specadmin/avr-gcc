#!/bin/bash


PREFIX_DIR="${HOME}/avr-gcc/usr"
NUM_THREADS=4

#GCC_VERSION="4.8.0"
#GCC_VERSION="5.1.0"
#GCC_VERSION="6.3.0"
GCC_VERSION="7.1.0"

##########################################

GCC_TAR="gcc-${GCC_VERSION}.tar.gz"
GCC_DIR="gcc-${GCC_VERSION}"
WGET_PARAMS="--passive-ftp --tries=3 -nc --progress=dot:binary"

WGET_CMD="wget ${WGET_PARAMS}"

if [ ! -f ${GCC_TAR} ]; then
echo "Fecthing GCC arhive"
$WGET_CMD ftp://ftp.gnu.org/gnu/gcc/${GCC_DIR}/${GCC_TAR}
fi

echo "Extracting files from GCC arhive"
rm -rf $GCC_DIR
tar -xf $GCC_TAR

echo "Configuring GCC"
mkdir $GCC_DIR/obj
cd $GCC_DIR/obj
../configure -v \
--target=avr \
--build=x86_64-linux-gnu \
--host=x86_64-linux-gnu \
--enable-languages=c,c++ \
--prefix=${PREFIX_DIR}/lib \
--infodir=${PREFIX_DIR}/share/info \
--mandir=${PREFIX_DIR}/share/man \
--bindir=${PREFIX_DIR}/bin \
--libexecdir=${PREFIX_DIR}/lib \
--libdir=${PREFIX_DIR}/lib \
--enable-shared \
--enable-long-long \
--enable-nls \
--disable-libssp \
--with-system-zlib 
