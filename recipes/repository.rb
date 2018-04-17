include_recipe 'apt::default' if ubuntu?

installtype = if ubuntu?
                'deb'
              else
                'rpm'
              end

node['scalr-server']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

packagecloud_repo 'scalr/scalr-server-ee' do
  type installtype
  master_token node['scalr-server']['repo_key']
end
