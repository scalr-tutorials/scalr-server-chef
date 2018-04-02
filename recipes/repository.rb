# include_recipe 'apt::default' if ubuntu?

installtype = if ubuntu?
                'deb'
              else
                'rpm'
              end
execute "curl -L https://#{node['scalr-server']['repo_key']}:@packagecloud.io/install/repositories/scalr/scalr-server-ee/script.#{installtype}.sh | sudo bash"


#
# node['scalr-server']['packages'].each do |pkg|
#   package pkg do
#     action :install
#   end
# end

# curl -L "${gpg_key_url}" 2> /dev/null | apt-key add - &>/dev/null

# apt_repository 'scalr-server-ee' do
#   uri 'https://packagecloud.io/scalr/scalr-server-ee/ubuntu/xenial'
#   distribution '/ubuntu/xenial'
#   # keyserver 'packagecloud.io/install/repositories/scalr/scalr-server-ee/gpg_key_url.list?os=Ubuntu&dist=xenial&name=testbox'
#    key ['9a2b3339b0b29641ea857f8e1b1051faa540c9544db4f47c', 'http://packagecloud.io/scalr/scalr-server-ee/gpgkey']
#   action :add
# end

# apt_repository 'rundeck' do
#   uri 'https://dl.bintray.com/rundeck/rundeck-deb'
#   distribution '/'
#   key ['379CE192D401AB61', 'http://rundeck.org/keys/BUILD-GPG-KEY-Rundeck.org.key']
#   keyserver 'keyserver.ubuntu.com'
#   action :add
# end

# gpg_key_install_url="https://9a2b3339b0b29641ea857f8e1b1051faa540c9544db4f47c:@packagecloud.io/install/repositories/scalr/scalr-server-ee/gpg_key_url.list?os=${os}&dist=${dist}&name=${unique_id}"
# apt_config_url="https://9a2b3339b0b29641ea857f8e1b1051faa540c9544db4f47c:@packagecloud.io/install/repositories/scalr/scalr-server-ee/config_file.list?os=${os}&dist=${dist}&name=${unique_id}&source=script"
#
#
# apt_source_path="/etc/apt/sources.list.d/scalr_scalr-server-ee.list"
# curl -L "${gpg_key_url}" 2> /dev/null | apt-key add - &>/dev/null
#
# apt-get update &> /dev/null
