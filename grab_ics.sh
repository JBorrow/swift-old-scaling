#!/bin/bash

mkdir output
cd output

cp ../swiftsim-v0.8.0/examples/EAGLE_25/getIC.sh ./getIC.sh
bash getIC.sh &

for version in 0.5.0 0.6.0 0.7.0 0.8.0;
do
    cp "../swiftsim-v${version}/examples/EAGLE_25/eagle_25.yml" "./eagle_25_${version}.yml"
    sed -i "s/\.\/EAGLE_ICs_25.hdf5/\.\.\/EAGLE_ICs_25.hdf5/g" "./eagle_25_${version}.yml"
done
