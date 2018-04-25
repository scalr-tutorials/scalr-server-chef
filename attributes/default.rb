# base repository

# base packages
default['scalr-server']['packages'] = if node['platform'] == 'ubuntu'
                                        ['gnupg', 'curl', 'apt-transport-https', 'debian-archive-keyring']
                                      else
                                        ['curl']
                                      end

# repository keys
default['scalr-server']['repo_key'] = 'xxx'

# default scalr folder
default['scalr-server']['folder'] = '/etc/scalr-server'

# environment
default['scalr-server']['environment'] = 'prod'

# data_bag
default['scalr-server']['data_bag'] = 'scalr-config'
default['scalr-server']['secrets'] = 'scalr-secrets'
default['scalr-server']['license'] = 'scalr-license'

# scalr-server verions
default['scalr-server']['version'] = '7.8.0.enterprise.xenial.b258-1'
