#!/bin/bash
#SBATCH -N 1 -n 4
##SBATCH -p milan
#SBATCH -t 00:10:00
#SBATCH -J distributed2

module purge
module load intel
module load impi
module load R

export I_MPI_DEBUG=30
export FI_LOG_LEVEL=debug
#export FI_PROVIDER=mlx
#export I_MPI_SPAWN=on
#export FI_MLX_NS_ENABLE=1
#export I_MPI_SPAWN_EXPERIMENTAL=1

#export I_MPI_FABRICS=shm:ofi
#export I_MPI_PMI_LIBRARY=$SLURM_I_MPI_PMI_LIBRARY 

# the recommended way to start MPI
srun Rscript distributed2.R 100
# alternatively
#mpirun np 1 distributed2.R 100
# or maybe?
#R --no-save -f distributed2.R 100

