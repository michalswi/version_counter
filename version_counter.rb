#!/usr/bin/env ruby

# min 0.1.0
# max 9.9.9

# TO DO
"""
check if policy_version.txt doesnt exist already

insert initial entry to policy_version.txt if empty/newly created:
0.1.0:<first_opaque_id_for_specific_policyfile>

how to get opaque

read policy_version.txt if exist, check version and opaque, if new version/opaque add to file

merge script with rake (not sure if needed)
"""

var = "1.9.8"
s = var.split(".")
f = []

# if, first element is '0' for example '0.1.0'
if var != "9.9.9"
	if s[0].to_i == 0 and var != "0.9.9"
		f << "0"
		p f
		p s[1..-1]
		new_s = s[1..-1].map { |k| "#{k}" }.join("")
		p (new_s.to_i + 1).to_s
		(((new_s.to_i + 1).to_s).split('')).each do |i|
			f << i
		end
	elsif var == "0.9.9" or 0 < s[0].to_i <= 9
		puts "test"
	end
	p f[0..-1].map { |k| "#{k}" }.join(".")
else
	p "no way!"
end
