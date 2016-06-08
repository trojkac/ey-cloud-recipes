#
# Cookbook Name:: replication_consistency_check
# Recipe:: default
#
#
# Cookbook Name:: replication_consistency_check
# Recipe:: default
#

# installation path for monitoring tool
install_path = '/data/monitoring'
file_name='replication_check.rb'

if node[:instance_role].include?('app_master')
  node[:applications].each do |app,data|

    app_var = {
        app: app
    }
    directory "#{install_path}" do
      owner 'deploy'
      group 'deploy'
      mode 0755
      action :create
      recursive true
    end

    template "#{install_path}/#{file_name}" do
      source "replication_check.rb.erb"
      owner 'deploy'
      group 'deploy'
      mode 0755
      variables app_var
    end

    cron 'database replication check' do
      user     'deploy'
      action   :create
      minute   '*/15'
      hour     '*'
      day      '*'
      month    '*'
      weekday  '*'
      command  "#{install_path}/#{file_name}"
    end


  end


end