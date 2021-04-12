#!/bin/sh
# this script requires c++ compiler and cmake system
tags=$*
mkfiletype="Unix Makefiles"
mkbin="make"
buildtype="Release"
binonly="0"
for tag in "${tags}"; do
  if echo "${tag}" | grep -iq "ninja"; then
    mkfiletype="Ninja"
    mkbin="ninja"
  fi
  if echo "${tag}" | grep -iq "debug"; then
    buildtype="Debug"
  fi
  if echo "${tag}" | grep -iq "bin"; then
    binonly="1"
  fi
done
if [ ${binonly} -eq 1 ]; then
  echo "[${0}] refresh ${buildtype} binaries with ${mkfiletype} ..."
else
  echo "[${0}] build ${buildtype} libraries and binaries with ${mkfiletype} ..."
fi

if [ ${binonly} -eq 0 ]; then
  echo "[${0}] clean up ..."
  if [ -d "./build" ]; then
    rm -rf build
  fi
  mkdir -p build/install
  mkdir -p build/opencv
fi

if [ ${binonly} -eq 0 ]; then
  echo "[${0}] build libraries ..."
  cd build/opencv &&
  cmake -G "${mkfiletype}" \
    -D CMAKE_BUILD_TYPE="${buildtype}" \
    -D CMAKE_FIND_ROOT_PATH="../install" \
    -D CMAKE_INSTALL_PREFIX="../install" \
    ../../opencv &&
  cmake --build . && ${mkbin} install && cd -
fi

echo "[${0}] build binaries ..."
cd build &&
cmake -G "${mkfiletype}" \
  -D CMAKE_BUILD_TYPE="${buildtype}" \
  -D CMAKE_FIND_ROOT_PATH="./install" \
  -D CMAKE_INSTALL_PREFIX="./install" \
  ../ &&
cmake --build . && cd -
