name		    'dummy_policy2'
default_source 	    :supermarket do |s|
  s.preferred_for "ntp"
end
run_list	    'ntp'
