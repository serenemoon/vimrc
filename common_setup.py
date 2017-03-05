#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import time
import os
HOME_DIR=os.path.expanduser('~')

TEST_BASEDIR=os.path.expanduser('~/Doc/Test')
TEST_DIRS=['c', 'cc', 'python', 'bash', 'make']
def TestDirSetup():
	count = 0
	if not os.path.exists(TEST_BASEDIR):
		print("Making test basedir {0}...".format(TEST_BASEDIR))
		os.makedirs(TEST_BASEDIR)
		count += 1
	for sdir in TEST_DIRS:
		sub_dir = TEST_BASEDIR + os.path.sep + sdir
		if not os.path.exists(sub_dir):
			print("\tMaking subdir {0}...".format(sub_dir))
			os.makedirs(sub_dir)
			count += 1
	if count != 0:
		print("Total {0} dirs created...".format(count))	

def ShAliasSetup():
	bash_file = '.bash_aliases'
	count = 0
	alias_cmds = ['cd' + v for v in TEST_DIRS ]
	with os.path.exists(bash_file) and open(bash_file, 'r+') or open(bash_file, 'x+') as f:
		for line in f:
			if line.strip().startswith('alias'):
				cmd = line.split('=')[0].split(' ')[-1]
				if cmd in alias_cmds:
					alias_cmds.remove(cmd)
		if len(alias_cmds):
			full_cmds = ['alias {0}="cd {1}"'.format(v, TEST_BASEDIR + os.path.sep + v[2:]) for v in alias_cmds]
			f.writelines('\n'.join(full_cmds))
		f.write('\nalias cdu="cd .."')
	while not os.path.exists(bash_file):
		time.sleep(1)		
	if len(alias_cmds) != 0:
		print('Total {0} alias cmds added...'.format(len(alias_cmds)))
		os.system('. ' + bash_file)

TestDirSetup()
ShAliasSetup()

