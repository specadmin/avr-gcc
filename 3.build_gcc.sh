#!/bin/bash


#PREFIX_DIR="${HOME}/avr-gcc/usr"
PREFIX_DIR="/usr"
NUM_THREADS=`nproc`

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

# A trick to disable debug info in libgcc.
# If there is any other proper way to do this please advice.
sed -i "s/LIBGCC2_DEBUG_CFLAGS = -g/LIBGCC2_DEBUG_CFLAGS =/g" ${GCC_DIR}/libgcc/Makefile.in

echo "Configuring GCC"
export LD_LIBRARY_PATH=/usr/lib 

mkdir $GCC_DIR/obj
cd $GCC_DIR/obj
LIBGCC_DEBUG_CFLAGS="" LIBGCC2_DEBUG_CFLAGS="" STAGE1_CFLAGS="" CFLAGS="-O2" CFLAGS_FOR_BUILD="-O2" CXXFLAGS_FOR_BUILD="-O2" BOOT_CFLAGS="-O2" CFLAGS="-O2" CXXFLAGS="-O2" CFLAGS_FOR_TARGET="-O2" CXXFLAGS_FOR_TARGET="-O2" ../configure -v \
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
--enable-long-long \
--enable-nls \
--disable-libssp \
--with-system-zlib 

make -j${NUM_THREADS}
make -j${NUM_THREADS} install-strip
