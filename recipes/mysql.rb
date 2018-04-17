include_recipe 'scalr-server::default'

template "#{node['scalr-server']['folder']}/scalr-server-local.rb" do
  source 'mysql.erb'
  variables(
    mysql_id: data_bag_item(node['scalr-server']['data_bag'], 'prod')['mysql'][0]['server_id'],
    mysql_slave: data_bag_item(node['scalr-server']['data_bag'], 'prod')['mysql'][1]['server_name']
  )
  notifies :run, 'execute[scalr-reconfigure]', :delayed
end

# execute 'setup mysql replications' do
#   command '/opt/scalr-server/bin/kickstart-replication 172.31.21.164:3306 172.31.17.3:3306'
# end
