#!/bin/bash
set -e
set -x

VERSION=6.7.288.46.1
GEM=libv8-$VERSION-x86_64-darwin-16.gem

if ! [ -f ${GEM} ]; then

    # Get the .a file from libv8 gem
    wget https://rubygems.org/downloads/${GEM}
    tar xvf ${GEM}
    tar xvf data.tar.gz

fi;

# Compile py_mini_racer extension
clang++ -Ivendor/v8/include \
    -Ivendor/v8 py_mini_racer/extension/mini_racer_extension.cc \
    -o py_mini_racer/_v8.so \
    vendor/v8/out/x64.release/libv8_{base,libbase,snapshot,libplatform,libsampler}.a \
    -ldl \
    -pthread \
    -std=c++11 \
    -stdlib=libc++ \
    -shared \
    -fPIC
