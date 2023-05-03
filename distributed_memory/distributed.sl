#!/bin/bash -e 
#SBATCH --job-name distributed 
#SBATCH --time 00:10:00 
#SBATCH --ntasks 12 
#SBATCH --output %x.%j.out 
#SBATCH --error %x.%j.err

njobs="50"
if [ "$#" -eq 1 ]; then
    njobs="$1"
fi

module load R
module load OpenMPI

echo "Executing $njobs jobs in R..." 
srun Rscript distributed.R $njobs
echo "R finished."

