include_recipe 'scalr-server::default'

template "#{node['scalr-server']['folder']}/scalr-server-local.rb" do
  source 'proxy.erb'
  notifies :run, 'execute[scalr-reconfigure]', :delayed
end
