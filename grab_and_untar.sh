#!/bin/bash

for version in 0.5.0 0.6.0 0.7.0 0.8.0;
do
    wget "https://gitlab.cosma.dur.ac.uk/swift/swiftsim/-/archive/v${version}/swiftsim-v${version}.tar.gz"
    tar -xzf "swiftsim-v${version}.tar.gz"
done

rm *.tar.gz
