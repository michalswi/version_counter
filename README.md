# policyfile version counter
https://docs.chef.io/policyfile.html


### available counters
- counter written in ruby [here](https://github.com/michalswi/version_counter/blob/master/version_counter.rb)
- counter written in python [here](https://github.com/michalswi/version_counter/blob/master/version_counter.py)

### how it works
'counter' based on *.lock.json files from dummy_test cookbook which stores policyfiles. Test policyfiles are ntp_policy.rb and sshd_policy.rb. 

If lock.json doesn't exist should be created. 

What 'counter' do:

- create './versions' directory (if doesn't exist already) where specific policy version file will be stored,
- create policy version file (if doesn't exist already) based on lock.json name e.g. ntp_policy.lock.json, policy version file will be called 'ntp_policy' and stored in './versions'
- take from ntp_policy.lock.json revision_id, add to './versions/ntp_policy' with the proper version for example:

0.1.0:fed7f9f8576bc906504e708defbcd53333b919ac2867b336ae0503853479eb1b

- if you generate another lock.json with the same revision_id, 'counter' won't add that to './versions/ntp_policy',
- if you change ntp_policy.rb and generate new ntp_policy.lock.json you will have new revision_id, 
- 'counter' will add to already existing './versions/ntp_policy' new version with the new revision_id for example:

0.1.1:fed7f9f8576bc906504e708defbcd53333b919ac2867b336ae05038534712345

- 'counter' based on policyfiles will generate tarballs in directory 'tarball'

Last step is to push archive (from './tarball') with the proper version (taken from './versions', for example 'ntp_policy')  to chef-server (could be automated in the future).

```ruby
$ chef push-archive 0.1.0 tarball/ntp_policy-6836c30d80...6.tgz
$ chef show-policy
ntp_policy
==========
* 0.1.0:  6836c30d80
```
