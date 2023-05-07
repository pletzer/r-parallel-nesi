#!/bin/bash -e 
#SBATCH --job-name distributed 
#SBATCH --time 00:10:00 
#SBATCH --ntasks 12 
#SBATCH --output %x.%j.out 
#SBATCH --error %x.%j.err

ntasks="50"
if [ "$#" -eq 1 ]; then
    ntasks="$1"
fi

module purge
module load R
#module load impi
#module load OpenMPI

echo "Executing $ntasks tasks in R..."

#export I_MPI_DEBUG=30
#export FI_LOG_LEVEL=debug
#export FI_PROVIDER=mlx
#export I_MPI_SPAWN=on
#export FI_MLX_NS_ENABLE=1
#export I_MPI_SPAWN_EXPERIMENTAL=1

#export I_MPI_FABRICS=shm:ofi
#export I_MPI_FABRICS=shm

srun Rscript distributed.R $ntasks
echo "R finished."
