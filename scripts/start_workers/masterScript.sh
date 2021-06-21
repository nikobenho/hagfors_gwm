#!/bin/sh -l

# JOB NAME AND TIME
#SBATCH -J runModelWorkers
#SBATCH -A lu2021-2-74
#SBATCH -p lu
#SBATCH -t 02:00:00

# REQUESTING THE NUMBER OF NODES NEEDED
#SBATCH -N 5

#SBATCH --tasks-per-node=20
#SBATCH --exclusive


# NOTIFICATIONS
#SBATCH --mail-user=nikolas.hoglund@geol.lu.se
#SBATCH --mail-type=ALL

# JOB NAME AND OUTPUT FILE NAMES
#SBATCH -o runModelWorkers_%j.out
#SBATCH -e runModelWorkers_%j.err

################# DOCSTRING ###################
#
#	The purpose of this script is to copy
#	the model onto a local node and start
#	parallel workers, one for each core.
#
############### END DOCSTRING #################

MODEL_NAME="hagfors_ss_template_100reals"

cat $0

# load Anaconda, source (necessary?), and activate environment
module load Anaconda3
source /sw/easybuild/software/Anaconda3/2020.11/etc/profile.d/conda.sh
source activate mytestenv
conda activate mytestenv

# Copying the model template onto the local disks of the nodes
srun -n $SLURM_NNODES -N $SLURM_NNODES cp -rp /home/nat12nho/snic2021-23-374/$MODEL_NAME $SNIC_TMP/

# set the number of jobs
export NB_of_jobs=100

# Loop over the job number

for ((i=0; i<$NB_of_jobs; i++))
do
    srun --export=ALL -Q --exclusive --overlap -n 1 -N 1 workerScript.sh $i &> worker_${SLURM_JOB_ID}_${i} &
    sleep 1
done

# keep the wait statement, it is important!
wait
