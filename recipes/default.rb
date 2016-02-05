#
# Cookbook Name:: chef-cachet
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe "chef-cachet::php"
include_recipe "nginx"

directory "#{node["cachet"]["root"]}" do
  owner node['cachet']['nginx_user']
  group node['cachet']['nginx_user']
  mode '0755'
  action :create
end

remote_file '/tmp/cachet.tar.gz' do
  source "https://github.com/CachetHQ/Cachet/archive/#{node['cachet']['version']}.tar.gz"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

bash 'unzip_cachet' do
  cwd "/tmp"
  code <<-EOH
    \
    tar xzf /tmp/cachet.tar.gz --strip-components=1 -C /var/www/cachet
  EOH
 # not_if { ::File.exists?(extract_path) }
end

bash 'install_cachet' do
  cwd "#{node["cachet"]["root"]}"
  code <<-EOH
    \
    composer install --no-dev -o
  EOH
  # not_if { ::File.exists?(extract_path) }
end

