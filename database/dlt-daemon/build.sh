#!/bin/bash
. ../../common.sh $1

echo "start compiling $PWD with $MODE"

rm -rf build_$MODE bin_$MODE
mkdir build_$MODE
pushd build_$MODE

cmake ../code \
    -DCMAKE_INSTALL_PREFIX=$PWD/../bin_$MODE \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_C_FLAGS="-w -Wno-unknown-warning-option" \
    -DCMAKE_CXX_FLAGS="-w -Wno-unknown-warning-option" \
    -DCMAKE_C_FLAGS_DEBUG=" -w -Wno-unknown-warning-option" \
    -DCMAKE_CXX_FLAGS_DEBUG=" -w -Wno-unknown-warning-option" \
    -DWITH_DOC=ON \
    -DWITH_MAN=ON \
    -DDLT_IPC=UNIX_SOCKET \
    -DDLT_USER_IPC_PATH=/ipc \
    -DWITH_DLT_DEBUGGERS=OFF \
    -DWITH_DLT_SYSTEM=OFF \
    -DWITH_DLT_TESTS=ON \
    -DWITH_DLT_USE_IPv6=OFF \
    -DWITH_EXTENDED_FILTERING=OFF \
    -DWITH_SYSTEMD=OFF \
    -DWITH_SYSTEMD_WATCHDOG=OFF \
    -DWITH_SYSTEMD_JOURNAL=OFF

if [[ $MODE == "asan" ]]; then
    bear -- make -j$JOBS || exit 1
else
    make -j$JOBS || exit 1
fi

make install || exit 1

popd

echo "end compiling $PWD with $MODE"
