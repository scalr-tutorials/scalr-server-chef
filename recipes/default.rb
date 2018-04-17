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
  version node['scalr-server']['version']
end

secrets_db = data_bag_item(node['scalr-server']['data_bag'], node['scalr-server']['secrets'])
template "#{node['scalr-server']['folder']}/scalr-server-secrets.json" do
  source 'scalr-server-secrets.json.erb'
  variables(
    root_password: secrets_db['mysql']['root_password'],
    scalr_mysql_password: secrets_db['mysql']['scalr_password'],
    repl_password: secrets_db['mysql']['repl_password'],
    memcached_password: secrets_db['memcached']['password'],
    scalr_rabbitmq_password: secrets_db['rabbitmq']['scalr_password'],
    scalr_influxdb_password: secrets_db['influxdb']['scalr_password'],
    admin_password: secrets_db['app']['admin_password'],
    secret_key: secrets_db['app']['secret_key'],
    id: secrets_db['app']['id']
  )
end

license_key = data_bag_item(node['scalr-server']['data_bag'], node['scalr-server']['license'])
file "#{node['scalr-server']['folder']}/license.json" do
  content license_key['license_file']
end

srv_db = data_bag_item(node['scalr-server']['data_bag'], node['scalr-server']['environment'])
template "#{node['scalr-server']['folder']}/scalr-server.rb" do
  source 'scalr-server.rb.erb'
  variables(
    enable_all: srv_db['enable_all'],
    endpoint: srv_db['endpoint'],
    master_mysql: srv_db['mysql'][0]['server_name'],
    slave_mysql: srv_db['mysql'][1]['server_name'],
    appservers1: srv_db['proxy'][0]['server_name'],
    appservers2: srv_db['proxy'][1]['server_name'],
    worker1: srv_db['worker'],
    influxdb: srv_db['influxdb']
  )
  notifies :run, 'execute[scalr-reconfigure]', :delayed
end

execute 'scalr-reconfigure' do
  command 'scalr-server-ctl reconfigure'
  action :nothing
end
