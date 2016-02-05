
remote_file "#{Chef::Config[:file_cache_path]}/epel-release-latest-7.noarch.rpm" do
  source "https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"
  action :create
end
remote_file "#{Chef::Config[:file_cache_path]}/webtatic-release.rpm" do
  source "https://mirror.webtatic.com/yum/el7/webtatic-release.rpm"
  action :create
end

rpm_package "epel" do
  source "#{Chef::Config[:file_cache_path]}/epel-release-latest-7.noarch.rpm"
  action :install
end

rpm_package "webtatic-release" do
  source "#{Chef::Config[:file_cache_path]}/webtatic-release.rpm"
  action :install
end


package ['git','php56w-fpm','php56w-common','php56w-mysql','php56w-mbstring','php56w-gd','php56w-pecl-apcu']
#package ['php56w-fpm','php56w-common','php56w-mysql','php56w-pecl-apcu']

bash 'Install Composer' do
  code <<-EOH
    \
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
  EOH
  # not_if { ::File.exists?(extract_path) }
end