#!/bin/bash

source modules.sh

mkdir bin
mkdir logs

# Non-vector versions
for version in 0.5.0 0.6.0;
do
    cd "swiftsim-v${version}"

    # Comment out engine_dump_snapshot
    sed -i '' "s/engine_dump_snapshot(e);//g" src/engine.c

    ./autogen.sh
    ./configure --disable-vec --with-tbbmalloc > "../logs/configure_log_${version}"
    make -j > "../logs/make_log${version}"

    mv examples/swift_mpi "../bin/swift_mpi_${version}"
    cd ..
done

# Vector versions
for version in 0.7.0 0.8.0;
do
    cd "swiftsim-v${version}"

    # Comment out engine_dump_snapshot
    sed -i "s/engine_dump_snapshot(e);//g" src/engine.c

    ./autogen.sh
    ./configure --with-tbbmalloc > "../logs/configure_log_${version}"
    make -j > "../logs/make_log${version}"

    mv examples/swift_mpi "../bin/swift_mpi_${version}"
    cd ..
done
