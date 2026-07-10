#!/bin/bash
. ../../common.sh $1

echo "start compiling $PWD with $MODE"

rm -rf build_$MODE bin_$MODE
mkdir build_$MODE
pushd build_$MODE

cmake ../code \
    -DCMAKE_INSTALL_PREFIX=$PWD/../bin_$MODE \
    -DCMAKE_BUILD_TYPE=Debug \
    -DDISABLE_DLT=ON \
    -DCMAKE_CXX_FLAGS_DEBUG="-g -O0 -w -Wno-error -Wno-unknown-warning-option"

if [[ $MODE == "asan" ]]; then
    bear -- make -j$JOBS || exit 1
else
    make -j$JOBS || exit 1
fi

make install || exit 1

popd

echo "end compiling $PWD with $MODE"
