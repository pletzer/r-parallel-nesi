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
module load OpenMPI

echo "Executing $ntasks tasks in R..." 
srun Rscript distributed.R $ntasks
echo "R finished."