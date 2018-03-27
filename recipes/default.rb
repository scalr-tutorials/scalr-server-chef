include_recipe 'apt::default' if ubuntu?

node['scalr-server']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

directory node['scalr-server']['folder'] do
  action :create
end

include_recipe 'scalr-server::repository'

package 'scalr-server' do
  action :install
end

template "#{node['scalr-server']['folder']}/scalr-server-secrets.json" do
  source 'scalr-server-secrets.json.erb'
end

template "#{node['scalr-server']['folder']}/license.json" do
  source 'license.json.erb'
end

template "#{node['scalr-server']['folder']}/scalr-server.rb" do
  source 'scalr-server.rb.erb'
  variables(
    enable_all: data_bag_item(node['scalr-server']['data_bag'], 'prod')['enable_all'],
    endpoint: data_bag_item(node['scalr-server']['data_bag'], 'prod')['endpoint'],
    master_mysql: data_bag_item(node['scalr-server']['data_bag'], 'prod')['mysql'][0]['server_name'],
    slave_mysql: data_bag_item(node['scalr-server']['data_bag'], 'prod')['mysql'][1]['server_name'],
    appservers1: data_bag_item(node['scalr-server']['data_bag'], 'prod')['proxy'][0]['server_name'],
    appservers2: data_bag_item(node['scalr-server']['data_bag'], 'prod')['proxy'][1]['server_name'],
    worker1: data_bag_item(node['scalr-server']['data_bag'], 'prod')['worker'],
    influxdb: data_bag_item(node['scalr-server']['data_bag'], 'prod')['influxdb']
  )
  variables(
           )
  notifies :run, 'execute[scalr-reconfigure]', :delayed
end

execute 'scalr-reconfigure' do
  command 'scalr-server-ctl reconfigure'
  action :nothing
end
