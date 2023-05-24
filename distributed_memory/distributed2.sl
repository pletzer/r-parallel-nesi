#!/bin/bash
#SBATCH -N 1 -n 4
#SBATCH -p milan
#SBATCH -t 00:10:00
#SBATCH -J distributed2
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --hint=nomultithread

module purge
module load intel
module load impi
module load R

#export I_MPI_DEBUG=30
#export FI_LOG_LEVEL=debug
#export I_MPI_HYDRA_DEBUG=yes

# https://community.intel.com/t5/Intel-oneAPI-HPC-Toolkit/MPI-Init-error-under-Slurm/m-p/1367321#M9275
#https://www.intel.com/content/www/us/en/docs/mpi-library/developer-reference-linux/2021-8/global-hydra-options.html#SECTION_FF7731B57A484C37BC16862C9ABC0866
I_MPI_SPAWN=on I_MPI_PIN_RESPECT_CPUSET=0 FI_PROVIDER=mlx mpirun -bootstrap slurm Rscript distributed2.R 100

