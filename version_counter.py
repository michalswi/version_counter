#!/usr/bin/env python
import os
# min 0.1.0
# max 9.9.9

var = "0.9.8"
s = var.split(".")
f = []

## VERSION COUNTER
# if, first element is '0' for example '0.1.0'
if var != "9.9.9":
	if int(s[0]) == 0 and var != "0.9.9":
		f += "0"
		f += str(int("".join(s[1:]))+1)
	elif var == "0.9.9" or 0 < int(s[0]) <= 9:
		f += str(int("".join(var.split(".")))+1)
	else:
		print "no way!"
	f = ".".join(f)
	print f
else:
	print "no way!"

## WORK WITH FILE
filename = 'policy_version.txt'
if os.path.isfile('./{}'.format(filename)):
	print "it is"
	#with open()
