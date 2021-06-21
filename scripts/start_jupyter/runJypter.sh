#!/bin/sh
#SBATCH -J runJupyterNotebooks
#SBATCH -A lu2021-2-74
#SBATCH -p lu
#SBATCH -t 01:00:00

#SBATCH -N 1
#SBATCH --tasks-per-node=1

#SBATCH -o runJupyter_%j.out
#SBATCH -e runJupyter_%j.err

#SBATCH --mail-user=nikolas.hoglund@geol.lu.se
#SBATCH --mail-type=ALL

module load Anaconda3
source /sw/easybuild/software/Anaconda3/2020.11/etc/profile.d/conda.sh
source activate mytestenv
conda activate mytestenv

###################   UNNECCESARY STUFF ? ####################
#conda create -n mytestenv
#Dont know if necessary
#conda install -c conda-forge shapely
#conda install -c conda-forge pyshp
#pip install flopy
#pip install shapely
#pip install pyemu
##################### END UNNECESSARY STUFF ? ################

# cd into local node
cd $SNIC_TMP

# Clone git repo to local node
git clone https://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@github.com/nikobenho/hagfors_gwm.git

# cd into binaries dir and allow execution - perhaps unneccesary
cd /local/slurmtmp.$SLURM_JOB_ID/hagfors_gwm/bins/linux
chmod +x mf6
chmod +x pestpp-ies

# cd back into tmpdir
cd $SNIC_TMP

# jupyter pertinent stuff
unset XDG_RUNTIME_DIR
jupyter-lab --no-browser --ip=$HOSTNAME --port=8888
module list
which python
