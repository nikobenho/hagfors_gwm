'''

This script will be called by the SLURM SBATCH-script.
Its purpose is to setup multiple workers on a single HPC-node.

The SLURM SBATCH-script will call this script once for each node.

'''
import os
import pyemu

### SETTINGS ### 
template_name = 'hagfors_ss_template' # Change this to whatever template is being used
pst_filename = 'hagfors.pst' # Change this to whatever pest-file is being used
t_d = os.path.join('..', template_name) # Template directory
num_workers = 20 # Number of local workers
ip_adress = os.environ['MODEL_MASTER'] # This is passed through the SBATCH script (printed from run_master.py)

### END SETTINGS ###

assert os.path.exists(t_d)," Couldn't find template directory!"

pst = pyemu.Pst(os.path.join(t_d, pest_file))

print(pst.pestpp_options)

pyemu.os_utils.start_workers(
    t_d,
    "pestpp-ies",
    pst_filename,
    num_workers = num_workers,
    local = ip_adress,
    master_dir = "master_pmc", 
    worker_root = '..'
)