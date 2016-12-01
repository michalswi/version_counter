#!/usr/bin/env ruby

# min 0.1.0
# max 9.9.9

# TO DO
"""
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

# EMPTY FILE
def empty(filename)
	# init vers & opaque for test, HOW TO READ OPAQUE??
	vers = '0.1.0'
	opa = 'a111'
	File.open(filename, 'w') do |file|
		file.write("#{vers}:#{opa}\n")
	end
end
		
# NOT EMPTY FILE
def not_empty(filename)
	last_line = File.open(filename).to_a.last.chomp
	vers, opa = last_line.strip().split(":")
	File.open(filename, 'a') do |file|
		file.write("#{version_counter(vers)}:#{opa}\n")
	end
end

# EMPTY OR NOT
def empty_or_not(filename)
	p File.size?(filename)
	if File.size?(filename) == nil
		p "empty"
		empty(filename)
	else
		p "not empty"
		not_empty(filename)
	end
end

# MAIN
def main(filename)
	# if file exist
	if File.file?("#{filename}")
		empty_or_not(filename)
	# else, doesn't exist, create
	else
		p "#{filename} doesn't exist but I created it, nice isn't it? ;]"
		# file with permission 664
		File.new(filename,'w+')
		empty_or_not(filename)
	end
end

main(policyfile_name)
