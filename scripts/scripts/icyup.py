#!/usr/env/python

import string
import sys
import os
from random import *
from subprocess import call

# generate random string 
st = string.ascii_letters + string.digits
rand_st = ''.join(choice(st) for x in range(6))

local_file = sys.argv[1]
ext = os.path.splitext(local_file)[1]
remote_file = 'upload/' + rand_st + ext

scp_cmd = 'scp ' + local_file + ' boop:' + remote_file
os.popen(scp_cmd)

print('https://xix.ph0x.me/' + rand_st + ext)
