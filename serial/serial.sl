#!/bin/bash -e 
#SBATCH --job-name serial
#SBATCH --time 00:10:00 
#SBATCH --output %x.%j.out 
#SBATCH --error %x.%j.err

module load R

echo "Executing R ..." 
srun Rscript serial.R
echo "R finished."

