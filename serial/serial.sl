#!/bin/bash -e 
#SBATCH --job-name serial
#SBATCH --time 00:10:00 
#SBATCH --output %x.%j.out 
#SBATCH --error %x.%j.err

module purge
module load R

echo "Executing $ntasks tasks in R..." 
srun Rscript serial.R $ntasks
echo "R finished."