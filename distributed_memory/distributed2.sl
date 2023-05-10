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

export I_MPI_DEBUG=30
export FI_LOG_LEVEL=debug
export I_MPI_HYDRA_DEBUG=yes

# https://community.intel.com/t5/Intel-oneAPI-HPC-Toolkit/MPI-Init-error-under-Slurm/m-p/1367321#M9275
#https://www.intel.com/content/www/us/en/docs/mpi-library/developer-reference-linux/2021-8/global-hydra-options.html#SECTION_FF7731B57A484C37BC16862C9ABC0866
I_MPI_SPAWN=on I_MPI_PIN_RESPECT_CPUSET=0 FI_PROVIDER=mlx mpirun -bootstrap ssh Rscript distributed2.R 100

# getting
#[mpiexec@wmc005] check_exit_codes (../../../../../src/pm/i_hydra/libhydra/demux/hydra_demux_poll.c:117): unable to run bstrap_proxy on wmc006 (pid 1976846, exit code 32512)
#[mpiexec@wmc005] poll_for_event (../../../../../src/pm/i_hydra/libhydra/demux/hydra_demux_poll.c:159): check exit codes error
#[mpiexec@wmc005] HYD_dmx_poll_wait_for_proxy_event (../../../../../src/pm/i_hydra/libhydra/demux/hydra_demux_poll.c:212): poll for event error
#[mpiexec@wmc005] HYD_bstrap_setup (../../../../../src/pm/i_hydra/libhydra/bstrap/src/intel/i_hydra_bstrap.c:1061): error waiting for event
#[mpiexec@wmc005] HYD_print_bstrap_setup_error_message (../../../../../src/pm/i_hydra/mpiexec/intel/i_mpiexec.c:1031): error setting up the bootstrap proxies
#[mpiexec@wmc005] Possible reasons:
#[mpiexec@wmc005] 1. Host is unavailable. Please check that all hosts are available.
#[mpiexec@wmc005] 2. Cannot launch hydra_bstrap_proxy or it crashed on one of the hosts. Make sure hydra_bstrap_proxy is available on all hosts and it has right permissions.
#[mpiexec@wmc005] 3. Firewall refused connection. Check that enough ports are allowed in the firewall and specify them with the I_MPI_PORT_RANGE variable.
#[mpiexec@wmc005] 4. Ssh bootstrap cannot launch processes on remote host. Make sure that passwordless ssh connection is established across compute hosts.
#[mpiexec@wmc005]    You may try using -bootstrap option to select alternative launcher.



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



