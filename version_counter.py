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
		print f
		return f
	else:
		print "Can't proceed with version 9.9.9"
		return ver
		

## WORK WITH FILE
# TO DO:
# file empty
# file not empty (under consideration if empty lines)

# EMPTY FILE
def empty(filename, id_revision):
	print "empty function"
	# initial version is always 0.1.0
	vers = '0.1.0'
	with open(filename, 'r+') as ef:
		ef.write(vers + ':' + id_revision + '\n')

# NOT EMPTY FILE
# WHAT HAPPEN IF ONE OF THE POLICYFILES is 9.9.9 ? -> ef.write(version_counter(vers).... append the same line
def not_empty(filename, id_revision):
	print "not_empty function"
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

# EMPTY OR NOT
def empty_or_not(filename, id_revision):
	if os.path.getsize(filename) == 0:
		print "-> empty"
		# ->
		empty(filename, id_revision)
	else:
		print "-> not empty"
		# ->
		not_empty(filename, id_revision)	

# MAIN
def main(filename,id_revision):
	if os.path.isfile(filename):
		# ->
		empty_or_not(filename, id_revision)
	else:
		print "{} doesn't exist but I created it, nice isn't it? ;]".format(filename)
		# file with permission 664
		subprocess.call(['touch', filename])
		# ->
		empty_or_not(filename, id_revision)

# VERIFY IF LOCK.JSON EXIST
def if_json_exist():
	dix = {}
	for f in os.listdir('./dummy_test'):
		if f.endswith('.lock.json'):
			with open('./dummy_test/{}'.format(f)) as policy_json:
				#print policy_json.readlines()[1]						# "revision_id": "a2222222",
				var = policy_json.readlines()[1].split(':')[1]		# "a2222222",
				regex = r"(?<=\")([^\"]+)(?=\")"
				m = re.search(regex, var)
				dix[f] = m.group()
	# check if not empty
	if bool(dix):
		return dix
	else:
		print "no lock.json!"
		sys.exit()

if __name__ == '__main__':
	for i in if_json_exist().items():
		main(i[0].split('.')[0], i[1])

#policyfile_name = 'policy_version.txt'	
#main(policyfile_name)
