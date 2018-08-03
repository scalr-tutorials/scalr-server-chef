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

# data_bag
default['scalr-server']['data_bag'] = 'scalr-config'
default['scalr-server']['secrets'] = 'scalr-secrets'
default['scalr-server']['license'] = 'scalr-license'

# scalr-server verions
default['scalr-server']['version'] = '7.10.1.enterprise.xenial.b316-1'

# scalr services
default['scalr-server']['enable_all'] = true
default['scalr-server']['endpoint'] = node['cloud']['public_ipv4_addrs']
default['scalr-server']['master_mysql'] = ''
default['scalr-server']['slave_mysql'] = ''
default['scalr-server']['appserver1'] = ''
default['scalr-server']['appserver2'] = ''
default['scalr-server']['worker1'] = ''
default['scalr-server']['influxdb'] = ''
