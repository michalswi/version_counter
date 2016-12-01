#!/usr/bin/env python
import os
import subprocess
import sys

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
			sys.exit("bye!")
		f = ".".join(f)
		print f
		return f
	else:
		print "no way!"
		sys.exit("bye!")

## WORK WITH FILE
# TO DO:
# file empty
# file not empty (under consideration if empty lines)

policyfile_name = 'policy_version.txt'

# EMPTY FILE
def empty(filename):
	# init vers & opaque for test, HOW TO READ OPAQUE??
	vers = '0.1.0'
	opa = 'a111'
	with open(filename, 'r+') as ef:
		ef.write(vers + ':' + opa + '\n')

# NOT EMPTY FILE
def not_empty(filename):
	last_line = subprocess.check_output(['tail', '-1', filename])
	vers, opa = last_line.strip().split(":")
	with open(filename, 'a') as ef:
		ef.write(version_counter(vers) + ':' + opa + '\n')

# EMPTY OR NOT
def empty_or_not(filename):
	if os.path.getsize(filename) == 0:
		print "empty"
		empty(filename)
	else:
		print "not empty"
		not_empty(filename)	

# MAIN
def main(filename):
	if os.path.isfile(filename):
		empty_or_not(filename)
	else:
		print "{} doesn't exist but I created it, nice isn't it? ;]".format(filename)
		# file with permission 664
		subprocess.call(['touch', filename])
		empty_or_not(filename)

if __name__ == '__main__':
	main(policyfile_name)
