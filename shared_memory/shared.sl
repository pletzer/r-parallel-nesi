#!/bin/bash -e 
#SBATCH --job-name shared 
#SBATCH --time 00:10:00 
#SBATCH --cpus-per-task 12 
#SBATCH --output %x.%j.out 
#SBATCH --error %x.%j.err

ntasks="50"
if [ "$#" -eq 1 ]; then
    ntasks="$1"
fi

module purge
module load R

echo "Executing $ntasks tasks in R..." 
srun Rscript shared.R $ntasks
echo "R finished."