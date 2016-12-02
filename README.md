# version_counter
https://docs.chef.io/policyfile.html

counter written in python [in progress]

counter written in ruby [in progress]

'counter' based on *.lock.json file from dummy_test(simple chef cookbook) where are created two policyfiles.
lock.json is a must if doesn't exist should be created.
what 'counter' do:
- create policyfile version file (if not already exist) based on lock.json name e.g. Policyfile.lock.json, version file will be called 'Policyfile',
- take from Policyfile.lock.json id_revision, add to 'Policyfile' with the proper version for example:

0.1.0:fed7f9f8576bc906504e708defbcd53333b919ac2867b336ae0503853479eb1b

- if you generate another lock.json with the same id_revision, 'counter' won't add that to 'Policyfile'
