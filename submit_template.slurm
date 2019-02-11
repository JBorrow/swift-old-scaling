#!/bin/bash -l

#SBATCH -J SWIFT-VERSION-EAGLE25-THREADS
#SBATCH -N 1
#SBATCH --tasks-per-node=2
#SBATCH -o output-THREADS-%j.out
#SBATCH -e error-THREADS-%j.err
#SBATCH -p cosma7
#SBATCH -A dp004
#SBATCH --exclusive

#SBATCH -t 48:00:00

source ../../modules.sh

mpirun -np 2 ../../bin/swift_mpi_VERSION -s -a -t THREADS ../eagle_25_VERSION.yml
