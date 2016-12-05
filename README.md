# version_counter
https://docs.chef.io/policyfile.html

### available counters
- counter written in ruby
- counter written in python

### how it works
'counter' based on *.lock.json file from dummy_test(simple chef cookbook) where are created two 'policyfiles.rb'.

if lock.json doesn't exist should be created.

what 'counter' do:
- create 'versions' directory (if doesn't exist already)
- create policyfile version file (if doesn't exist already) based on lock.json name e.g. Policyfile.lock.json, version file will be called 'Policyfile',
- take from Policyfile.lock.json id_revision, add to 'Policyfile' with the proper version for example:

0.1.0:fed7f9f8576bc906504e708defbcd53333b919ac2867b336ae0503853479eb1b

- if you generate another lock.json with the same id_revision, 'counter' won't add that to 'Policyfile'
- if you change Policyfile.rb, generate new Policyfile.lock.json that means we will have new id_revision then
'counter' will add to already existing 'Policyfile' new version with new id_revision for example:

0.1.1:fed7f9f8576bc906504e708defbcd53333b919ac2867b336ae05038534712345
