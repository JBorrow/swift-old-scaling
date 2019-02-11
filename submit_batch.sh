#!/bin/bash

cd output

for version in 0.5.0 0.6.0 0.7.0 0.8.0;
do
    mkdir $version
    cd $version
    for thread in 1 2 4 7 14;
    do
        sbatch "./submit_${thread}.slurm" | tr ' ' '\n' | grep "[0-9000000]" >> submitted.txt
    done
    cd ..
done
