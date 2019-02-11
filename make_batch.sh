#!/bin/bash

cd output

for version in 0.5.0 0.6.0 0.7.0 0.8.0;
do
    mkdir $version
    cd $version
    for thread in 1 2 4 7 14;
    do
        cp ../../submit_template.slurm "./submit_${thread}.slurm"
        sed -i "s/THREADS/${thread}/g" "./submit_${thread}.slurm"
        sed -i "s/VERSION/${version}/g" "./submit_${thread}.slurm"
    done
    cd ..
done
