#!/usr/bin/env python
import os
import subprocess
import sys
import re

# min 0.1.0
# next 0.1.1
# max 9.9.9

## VERSION COUNTER
def version_counter(ver):
	s = ver.split(".")
	f = []
	# if, first element is '0' for example '0.1.0'
	if ver != "9.9.9":
		if int(s[0]) == 0 and ver != "0.9.9":
			f += "0"
			f += str(int("".join(s[1:]))+1)
		elif var == "0.9.9" or 0 < int(s[0]) <= 9:
			f += str(int("".join(ver.split(".")))+1)
		else:
			print "no way!"
		f = ".".join(f)
		return f
	else:
		print "Can't proceed with version 9.9.9"
		return ver

## WORK WITH FILE
# TO DO:
# file not empty (under consideration if empty lines)
# what happen if one of the policies version is 9.9.9 ? -> policyver.write(version_counter(vers).... append the same line

# VERIFY IF LOCK.JSON EXIST
def if_json_exist():
	dix = {}
	for f in os.listdir('./dummy_test'):
		if f.endswith('.lock.json'):
			with open('./dummy_test/{}'.format(f)) as id_rev:
				var = id_rev.readlines()[1].split(':')[1]
				regex = r"(?<=\")([^\"]+)(?=\")"
				m = re.search(regex, var)
				dix[f] = m.group()
	# check if not empty
	if bool(dix):
		return dix
	else:
		print "no lock.json!"
		sys.exit()

# CREATE tarball
def tar(dic):
	for i in dic.keys():
		os.system("chef export ./dummy_test/{}.rb -a tarball".format(i.split('.')[0]))
				
# EMPTY FILE
def empty(filename, id_revision):
	# initial version is always 0.1.0
	vers = '0.1.0'
	with open(filename, 'r+') as ef:
		ef.write(vers + ':' + id_revision + '\n')
		tar(if_json_exist())

# NOT EMPTY FILE
def not_empty(filename, id_revision):
	#last_line = subprocess.check_output(['tail', '-1', filename])
	#vers, opa = last_line.strip().split(":")
	with open(filename, 'a+') as policyver:
		for i in policyver.readlines():
			vers, opa = i.split(":")
			if opa.strip() == id_revision:
				print "For %s requested id_revision:%s already exist under version:%s" %(filename, opa.strip(), vers)
				break
			else:
				policyver.write(version_counter(vers) + ':' + id_revision + '\n')
				tar(if_json_exist())

# EMPTY OR NOT
def empty_or_not(filename, id_revision):
	if os.path.getsize(filename) == 0:
		empty(filename, id_revision)
	else:
		not_empty(filename, id_revision)	

# MAIN
def main(filename, id_revision):
	if os.path.isfile('./versions/{}'.format(filename)):
		# ->
		empty_or_not('./versions/{}'.format(filename), id_revision)
	else:
		print "{} was created".format(filename)
		# file with permission 664
		subprocess.call(['touch', './versions/{}'.format(filename)])
		# ->
		empty_or_not('./versions/{}'.format(filename), id_revision)

# RUN main()
def run():
	for i in if_json_exist().items():
		main(i[0].split('.')[0], i[1])
		
# EXECUTE script
if __name__ == '__main__':
	if os.path.isdir('./versions'):
		run()
	else:
		os.system('mkdir -p versions')
		run()
