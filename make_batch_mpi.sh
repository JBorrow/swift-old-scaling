#!/bin/bash

cd output

for version in 0.5.0 0.6.0 0.7.0 0.8.0;
do
    cd $version
    for node in 2 4 8;
    do
        cp ../../submit_template_mpi.slurm "./submit_mpi_${node}.slurm"
        sed -i "s/NODES/${node}/g" "./submit_mpi_${node}.slurm"
        sed -i "s/VERSION/${version}/g" "./submit_mpi_${node}.slurm"
    done
    cd ..
done
