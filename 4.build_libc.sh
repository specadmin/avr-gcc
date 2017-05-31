#!/bin/bash


#PREFIX_DIR="${HOME}/avr-gcc/usr"
PREFIX_DIR="/usr"
NUM_THREADS=`nproc`

#LIB_VERSION="1.8.1"
LIB_VERSION="2.0.0"

##########################################

LIB_TAR="avr-libc-${LIB_VERSION}.tar.bz2"
LIB_DIR="avr-libc-${LIB_VERSION}"
WGET_PARAMS="--passive-ftp --tries=3 -nc --progress=dot:LIBary"

WGET_CMD="wget ${WGET_PARAMS}"

if [ ! -f ${LIB_TAR} ]; then
echo "Fecthing avr-libc  arhive"
$WGET_CMD http://download.savannah.gnu.org/releases/avr-libc/${LIB_TAR}
fi

echo "Extracting files from LIB arhive"
rm -rf $LIB_DIR
tar -xf $LIB_TAR

echo "Configuring avr-libc"
export LD_LIBRARY_PATH=/usr/lib 
mkdir $LIB_DIR/obj
cd $LIB_DIR/obj
../configure -v \
--target=avr \
--build=x86_64-linux-gnu \
--host=avr \
--disable-debug-info \
--prefix=${PREFIX_DIR}/lib \
--infodir=${PREFIX_DIR}/share/info \
--mandir=${PREFIX_DIR}/share/man \
--bindir=${PREFIX_DIR}/bin \
--libexecdir=${PREFIX_DIR}/lib \
--libdir=${PREFIX_DIR}/lib 

make -j${NUM_THREADS} install-strip