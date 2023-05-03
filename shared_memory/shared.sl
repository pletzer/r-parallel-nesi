#!/bin/bash -e 
#SBATCH --job-name shared 
#SBATCH --time 00:10:00 
#SBATCH --cpus-per-task 12 
#SBATCH --output %x.%j.out 
#SBATCH --error %x.%j.err

module load R

echo "Executing R ..." 
srun Rscript shared.R
echo "R finished."

