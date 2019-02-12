#!/bin/bash

cd output

for version in 0.5.0 0.6.0 0.7.0 0.8.0;
do
    cd $version
    for node in 2 4 8;
    do
        sbatch "./submit_mpi_${node}.slurm" | tr ' ' '\n' | grep "[0-9000000]" >> submitted.txt
    done
    cd ..
done
