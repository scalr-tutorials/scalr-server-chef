include_recipe 'scalr-server::default'

template "#{node['scalr-server']['folder']}/scalr-server-local.rb" do
  source 'mysql.erb'
  variables(
    mysql_id: data_bag_item(node['scalr-server']['data_bag'], 'prod')['mysql'][1]['server_id']
  )
  notifies :run, 'execute[scalr-reconfigure]', :delayed
end
