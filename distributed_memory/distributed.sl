#!/bin/bash -e 
#SBATCH --job-name distributed 
#SBATCH --time 00:10:00 
#SBATCH --ntasks 12 
#SBATCH --output %x.%j.out 
#SBATCH --error %x.%j.err

module load R
module load OpenMPI

echo "Executing R ..." 
srun Rscript distributed.R
echo "R finished."

