# version_counter
https://docs.chef.io/policyfile.html

### available counters
- counter written in ruby[here](https://github.ibm.com/michal-swierczewski/version_counter/blob/master/version_counter.rb)
- counter written in python[here](https://github.ibm.com/michal-swierczewski/version_counter/blob/master/version_counter.py)

### how it works
'counter' based on *.lock.json files from dummy_test(simple chef cookbook) where are created two policyfiles (Policyfile.rb and Policyfile2.rb).    
If lock.json doesn't exist should be created. What 'counter' do:

- create './versions' directory (if doesn't exist already) where policy version file will be stored,
- create policy version file (if doesn't exist already) based on lock.json name e.g. Policyfile.lock.json, policy version file will be called 'Policyfile' and stored in './versions'
- take from Policyfile.lock.json revision_id, add to './versions/Policyfile' with the proper version for example:

0.1.0:fed7f9f8576bc906504e708defbcd53333b919ac2867b336ae0503853479eb1b

- if you generate another lock.json with the same revision_id, 'counter' won't add that to './versions/Policyfile',
- if you change Policyfile.rb and generate new Policyfile.lock.json you will have new revision_id, 
- 'counter' will add to already existing './versions/Policyfile' new version with the new revision_id for example:

0.1.1:fed7f9f8576bc906504e708defbcd53333b919ac2867b336ae05038534712345

- 'counter' based on policyfiles (Policyfile.rb and Policyfile2.rb) will create tarballs in directory 'tarball',

- [in progress]
