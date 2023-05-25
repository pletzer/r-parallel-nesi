#!/bin/bash -e 
#SBATCH -n 1 
#SBATCH --job-name shared 
#SBATCH --time 00:20:00 
#SBATCH --cpus-per-task 21
#SBATCH --output %x.%j.out 
#SBATCH --error %x.%j.err
#SBATCH --partition milan
#SBATCH --hint nomultithread

ntasks="10000"
if [ "$#" -eq 1 ]; then
    ntasks="$1"
fi

module purge
module load R

echo "Executing $ntasks tasks in R..." 
srun Rscript shared.R $ntasks
echo "R finished."
