#!/usr/bin/python

import string
import sys
import os
from random import *
import subprocess

# generate random string 
st = string.ascii_letters + string.digits
rand_st = ''.join(choice(st) for x in range(6))

local_file = sys.argv[1]
ext = os.path.splitext(local_file)[1]
remote_file = '/home/icy/upload/' + rand_st + ext

#scp_cmd = 'scp ' + local_file + ' boop:' + remote_file
p = subprocess.Popen(['scp', '-r', local_file, '%s' % ('boop: ') , remote_file], bufsize=2048)
p.wait()

print('https://xix.ph0x.me/' + rand_st + ext)
