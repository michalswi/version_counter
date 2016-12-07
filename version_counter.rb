#!/usr/bin/env ruby

# min 0.1.0
# next 0.1.1
# max 9.9.9

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
		end
		p f[0..-1].map { |k| "#{k}" }.join(".")
		return f[0..-1].map { |k| "#{k}" }.join(".")
	else
		p "Can't proceed with version 9.9.9"
		return ver
	end
end

## WORK WITH FILE
# TO DO:
# file not empty (under consideration if empty lines)
# what happen if one of the policies version is 9.9.9 ? -> policyver.write(version_counter(vers).... append the same line

# VERIFY IF LOCK.JSON EXIST
def if_json_exist()
	dix = {}
	lock_j = Dir.glob("./dummy_test/*.lock.json")
	if lock_j != []
		lock_j.each do |f|
			File.open(f) do |id_rev|
				var = id_rev.readlines()[1].split(':')[1].chomp()
				/[\w\d]+/.match(var)
				dix[f.split('/')[-1]] = Regexp.last_match[0]
			end
		end
	end
	if dix.any?
		# dix: *.lock.json:revision_id
		return dix
	else
		abort("no lock.json!")
	end
end

# CREATE tarball
def tar(dic)
	if File.directory?("./tarball")
		# how to avoid creating the same tarballs one more time?
		p "exist"
	else
		dic.each do |i|
			system "chef export ./dummy_test/#{i[0].split('.')[0]}.rb -a tarball"
		end
	end
end

# EMPTY FILE
def empty(filename, id_revision)
	# initial version is always 0.1.0
	vers = '0.1.0'
	File.open(filename, 'w') do |ef|
		ef.write("#{vers}:#{id_revision}\n")
	end
end
		
# NOT EMPTY FILE*
def not_empty(filename, id_revision)
	#last_line = File.open(filename).to_a.last.chomp
	#vers, opa = last_line.strip().split(":")
	File.open(filename, 'a+') do |policyver|
		var = policyver.readlines()
		var.each do |i|
			vers, opa = i.split(':')
			if opa.chomp() == id_revision
				p "For #{filename} requested id_revision:#{id_revision} already exist under version:#{vers}"
				break
			else
				policyver.write("#{version_counter(vers)}:#{id_revision}\n")
			end
		end
	end
end

# EMPTY OR NOT
def empty_or_not(filename, id_revision)
	if File.size?(filename) == nil
		empty(filename, id_revision)
	else
		not_empty(filename, id_revision)
	end
end

# MAIN
def main(filename, id_revision)
	if File.file?("./versions/#{filename}")
		# ->
		empty_or_not("./versions/#{filename}", id_revision)
	else
		p "#{filename} was created"
		# file with permission 664
		File.new("./versions/#{filename}",'w+')
		# ->
		empty_or_not("./versions/#{filename}", id_revision)
	end
end

# RUN main()
def run()
	if_json_exist().each do |f|
		main(f[0].split('.')[0],f[1])
	end
end

# EXECUTE script
if Dir.exists?('./versions')
	run()
	tar(if_json_exist())
else
	Dir.mkdir('versions')
	run()
	tar(if_json_exist())
end
