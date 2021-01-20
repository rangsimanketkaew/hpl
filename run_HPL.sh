#!/bin/bash
 
#SBATCH --job-name="HPL"    # Job name
#SBATCH --nodes=2             # Total number of nodes requested
#SBATCH --ntasks=24           # Total number of mpi tasks
#SBATCH --ntasks-per-node=12  # Number of tasks per each node
###SBATCH --cpus-per-task=2     # Total number of CPUs per task
###SBATCH --ntasks-per-core=1  # Number of tasks per each core
###SBATCH --mem-per-cpu=4000    # Memory (in MB)
###SBATCH --nodelist=pollux[2-3]
#SBATCH --time=120:00:00    # Run time (hh:mm:ss)
#SBATCH --partition=chalawan_gpu       # Name of partition

cd ${SLURM_SUBMIT_DIR}

echo "This job's process 0 host is: " `hostname`

module purge
module load intel/19.0.5.281

ulimit -c 0
ulimit -s unlimited

# Optimize Intel MPI parallel method
export I_MPI_FABRICS=shm:ofi
export I_MPI_FALLBACK=0
export I_MPI_PIN_DOMAIN=auto
export I_MPI_HYDRA_BRANCH_COUNT=-1
export I_MPI_HYDRA_PMI_CONNECT=alltoall
export I_MPI_DAPL_DIRECT_COPY_THRESHOLD=655360

# Set total number of MPI processes for the HPL (should be equal to PxQ).
export MPI_PROC_NUM=$SLURM_NTASKS
export MPI_PER_NODE=$SLURM_NTASKS_PER_NODE

echo "MPI request"
echo $MPI_PROC_NUM
echo $MPI_PER_NODE

export OUT=demo_xhpl_intel64_dynamic_outputs.txt
export HPL_EXE=xhpl_intel64_dynamic

echo "HPL.dat: " >> $OUT
cat HPL.dat >> $OUT
echo "Binary name: " >> $OUT
ls -l xhpl_intel64_dynamic >> $OUT
echo "Environment variables: " >> $OUT
env >> $OUT
echo "Actual run: " >> $OUT

mpirun -perhost ${MPI_PER_NODE} -np ${MPI_PROC_NUM} ./runme_intel64_prv "$@" | tee -a $OUT

echo -n "Done: " >> $OUT
date >> $OUT

