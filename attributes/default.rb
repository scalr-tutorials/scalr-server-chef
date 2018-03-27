# base repository

# base packages
default['scalr-server']['packages'] = if node['platform'] == 'ubuntu'
                                        ['gnupg', 'curl', 'apt-transport-https', 'debian-archive-keyring']
                                      else
                                        ['curl']
                                      end

# repository keys
default['scalr-server']['repo_key'] = '9a2b3339b0b29641ea857f8e1b1051faa540c9544db4f47c'

# default scalr folder
default['scalr-server']['folder'] = '/etc/scalr-server'

default['scalr-server']['data_bag'] = 'scalr-config'
