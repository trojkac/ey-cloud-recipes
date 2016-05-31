#
# Cookbook Name:: update_pt_version
# Recipe:: default
#
if node[:instance_role][/app_master/]
  toolkit_version = '2.2.16'

  enable_package "dev-db/percona-toolkit" do
    version toolkit_version
    override_hardmask true
  end

  package "dev-db/percona-toolkit" do
    version toolkit_version
    action :install
  end
end