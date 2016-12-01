#!/usr/bin/env ruby

# min 0.1.0
# max 9.9.9

# TO DO
"""
check if policy_version.txt exist, if exist is it empty or not

insert initial entry to policy_version.txt if empty/newly created:
0.1.0:<first_opaque_id_for_specific_policyfile>

how to get opaque

read policy_version.txt if exist, check version and opaque, if new version/opaque add to file

merge script with rake (not sure if needed)
"""

var = "0.1.0"

## VERSION COUNTER
def version_counter(ver)
	s = ver.split(".")
	f = []
	# if, first element is '0' for example '0.1.0'
	if ver != "9.9.9"
		if s[0].to_i == 0 && ver != "0.9.9"
			f << "0"
			new_s = s[1..-1].map { |k| "#{k}" }.join("")
			(((new_s.to_i + 1).to_s).split('')).each do |i|
				f << i
			end
		# in ruby can't 0 < s[0].to_i <= 9
		elsif ver == "0.9.9" || 0 < s[0].to_i && s[0].to_i <= 9
			new_s = s[0..-1].map { |k| "#{k}" }.join("")
			(((new_s.to_i + 1).to_s).split('')).each do |i|
				f << i
			end
		else
			p "no way!"
			abort("bye!")
		end
		p f[0..-1].map { |k| "#{k}" }.join(".")
		return f[0..-1].map { |k| "#{k}" }.join(".")
	else
		p "no way!"
		abort("bye!")
	end
end

version_counter(var)

## WORK WITH FILE
# TO DO:
# file empty
# file not empty (under consideration if empty lines)

policyfile_name = 'policy_version.txt'
# init ver_opaque for test, how to read it?
vers = '0.1.0'
opa = 'a111'

# MAIN

# EMPTY FILE
def empty(filename)
	pass
end

# NOT EMPTY FILE
def not_empty(filename)
	pass
end

def main(filename)
	if File.file?("#{filename}")
		
	end
end

main(policyfile_name)
