'''
This script is called in the SBATCH-script runManager.sh

The purpose of this script is to print out the IP-adress
of the manager (since manager and worker cannot(?) be on
the same node without causing OOM-error). IP must be
changed manually (this is done in workerScript.sh) each
time an SBATCH job is submitted to the SLURM system.
'''

import socket

print('PEST MASTER/MANAGER INFO:')

hostname = socket.gethostname()
print('hostname is: '+hostname)

local_ip = socket.gethostbyname(hostname)

print('local ip is: '+local_ip)