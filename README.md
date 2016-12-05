# version_counter
https://docs.chef.io/policyfile.html

### available counters
- counter written in ruby
- counter written in python

### how it works
'counter' based on *.lock.json files from dummy_test(simple chef cookbook) where are created two 'policyfiles.rb'. If lock.json doesn't exist should be created.   
What 'counter' do:

- create 'versions' directory (if doesn't exist already) where policyfile version will be stored,
- create policyfile version file (if doesn't exist already) based on lock.json name e.g. Policyfile.lock.json, version file will be called 'Policyfile',
- take from Policyfile.lock.json id_revision, add to 'Policyfile' with the proper version for example:

0.1.0:fed7f9f8576bc906504e708defbcd53333b919ac2867b336ae0503853479eb1b

- if you generate another lock.json with the same id_revision, 'counter' won't add that to 'Policyfile',
- if you change Policyfile.rb and generate new Policyfile.lock.json you will have new id_revision, 
- 'counter' will add to already existing 'Policyfile' new version with the new id_revision for example:

0.1.1:fed7f9f8576bc906504e708defbcd53333b919ac2867b336ae05038534712345
