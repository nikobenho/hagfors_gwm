import socket

print('PEST MASTER/MANAGER INFO:')

hostname = socket.gethostname()
print('hostname is: '+hostname)

local_ip = socket.gethostbyname(hostname)

print('local ip is: '+local_ip)