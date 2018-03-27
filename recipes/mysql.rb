include_recipe 'scalr-server::default'

template "#{node['scalr-server']['folder']}/scalr-server-local.rb" do
  source 'mysql.erb'
  variables(
    mysql_id: data_bag_item(node['scalr-server']['data_bag'], 'prod')['mysql'][0]['server_id'],
    mysql_slave: data_bag_item(node['scalr-server']['data_bag'], 'prod')['mysql'][1]['server_name']
  )
  notifies :run, 'execute[scalr-reconfigure]', :delayed
end
