#!/bin/bash
#SBATCH -N 1 -n 4
#SBATCH -p milan
#SBATCH -t 00:10:00
#SBATCH -J distributed2
#SBATCH --error %x-%j.err
#SBATCH --output %s-%j.out

module purge
module load intel
module load impi
module load R

# https://community.intel.com/t5/Intel-oneAPI-HPC-Toolkit/MPI-Init-error-under-Slurm/m-p/1367321#M9275
I_MPI_SPAWN=on I_MPI_PIN_RESPECT_CPUSET=0 FI_PROVIDER=mlx mpirun -bootstrap ssh Rscript distributed2.R 100


#export I_MPI_DEBUG=30
#export FI_LOG_LEVEL=debug
#export FI_PROVIDER=mlx
#export I_MPI_SPAWN=on
#export FI_MLX_NS_ENABLE=1
#export I_MPI_SPAWN_EXPERIMENTAL=1

#export I_MPI_FABRICS=shm:ofi
#export I_MPI_PMI_LIBRARY=$SLURM_I_MPI_PMI_LIBRARY 

# the recommended way to start MPI
#srun Rscript distributed2.R 100
# alternatively
#mpirun np 1 distributed2.R 100
# or maybe?
#R --no-save -f distributed2.R 100



