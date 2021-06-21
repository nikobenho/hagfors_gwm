#!/bin/sh
#SBATCH -J runModelManager
#SBATCH -A lu2021-7-51
#SBATCH -p lu
#SBATCH -t 00:30:00

#SBATCH -N 1
#SBATCH --tasks-per-node=1
#SBATCH --mem-per-cpu=6200

#SBATCH -o nikotest_%j.out
#SBATCH -e nikotest_%j.err

#SBATCH --mail-user=nikolas.hoglund@geol.lu.se
#SBATCH --mail-type=ALL

################# DOCSTRING ##################
#
#	The purpose of this script is to
#	start the PEST manager and print the
#	manager IP for workers to connct to
#
############### END DOCSTRING ################

# cd into local node
cd $SNIC_TMP

# load Anaconda, source (necessary?), and activate env
module load Anaconda3
source /sw/easybuild/software/Anaconda3/2020.11/etc/profile.d/conda.sh
source activate mytestenv
conda activate mytestenv

# copy model dir from nobackup to local disk
cp -r /home/nat12nho/snic2021-23-374/test_ml/ $SNIC_TMP/
cp -r /home/nat12nho/snic2021-23-374/scripts/ $SNIC_TMP/

# cd into scripts dir and run script to print master node local ip
cd $SNIC_TMP/scripts/
python run_master.py

# cd into template dir dir and allow execution
cd $SNIC_TMP/test_ml/
chmod +x mf6
chmod +x pestpp-ies

# run pestpp-ies
pestpp-ies hagfors.pst /H :4004
