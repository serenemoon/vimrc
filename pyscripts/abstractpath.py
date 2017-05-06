#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re
import os.path as p
import glob
TOPPATH = '/home/warm/Doc/Code/hione'
re_joinstr = r'@@'
re_lci=re.compile(r'LOCAL_C_INCLUDES.*?=(.*?)(?<!\\)' + re_joinstr)
emptyline = 'EMPTYHOLDER'
def CreatePathFile(curdir):
	"""TODO: Docstring for CreatePathFile.

	:absdir: absolute path of a directory
	:returns: nothing

	"""
	os.chdir(curdir)
	amkfile = p.join(curdir, 'Android.mk')
	if not p.exists(amkfile):
		return

	with open(amkfile, 'r') as f:
		content = [ l.strip() or emptyline for l in f.readlines()]
		line    = re_joinstr.join(content)
		miter   = re_lci.findall(line)
		if not miter:
			return
		mfiles = ' '.join(miter)
		mfiles = re.sub(r'\\' + re_joinstr, ' ', mfiles)
		mfiles = re.sub(r'\$\(TOP\)', TOPPATH, mfiles)
		mfiles = re.sub(r'\$\(LOCAL_PATH\)', curdir, mfiles)
		mfiles = 'set path&|set path+=' + ','.join([p.abspath(_f.rstrip('/')) for _f in re.split(r'\s+', mfiles) if _f and _f != emptyline])
		with open('.vim_inc_path', 'w') as wf:
			print("{0}:creating .vim_inc_path...".format(rootdir))
			wf.write(mfiles)

if __name__ == '__main__':
	curdir = os.getcwd()
	for rootdir, dirs, files in os.walk(curdir):
		if 'Android.mk' in files:
			CreatePathFile(rootdir)
#		for onedir in dirs:
#			if p.exists(p.join(rootdir, onedir, 'Android.mk')):



def AbstractIncPaths(filename):
	"""TODO: Docstring for AbstractIncPaths.
	:returns: TODO

	"""
	if not p.exists(filename):
		return
	content = ''.join([l.strip() + '\0' for l in open(filename, 'r').readlines()])
	relci = re.compile(r'(?<=LOCAL_C_INCLUDES.*?=).*?(?<!\\)(?=\0)')
	match = ' '.join(relci.findall(content))
	match = re.sub(r'[\\\0]+', ' ', match)
	match = re.sub(r'\$\(TOP\)', TOPPATH, match)
	match = re.sub(r'\$\(LOCAL_PATH\)', p.dirname(filename), match)
	match = re.split(r'\s+', match)
	
