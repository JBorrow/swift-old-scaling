#!/bin/bash -l

#SBATCH -J SWIFT-VERSION-EAGLE25-MPI-NODES
#SBATCH -N NODES
#SBATCH --tasks-per-node=2
#SBATCH -o output-mpi-NODES-%j.out
#SBATCH -e error-mpi-NODES-%j.err
#SBATCH -p cosma7
#SBATCH -A dp004
#SBATCH --exclusive

#SBATCH -t 48:00:00

source ../../modules.sh

ranks=$((NODES*2))

mpirun -np $ranks ../../bin/swift_mpi_VERSION -s -a -t 14 -n 4096 ../eagle_25_VERSION.yml
