#
# Author:: Joshua Timberman <joshua@opscode.com>
# Author:: Joshua Sierles <joshua@37signals.com>
# Cookbook Name:: chef_pkg
# Recipe:: server
#
# Copyright 2008-2009, Opscode, Inc
# Copyright 2009, 37signals
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "chef_pkg::client"

%w{chef-indexer chef-server}.each do |svc| 
  service svc do
    supports [ :restart, :reload, :status ]
    action :nothing
  end
end

if node[:chef][:server_log] == "STDOUT"
  server_log = node[:chef][:server_log]
  server_show_time = "false"
else
  server_log = "\"#{node[:chef][:server_log]}\""
  server_show_time = "true"
end

if node[:chef][:indexer_log] == "STDOUT"
  indexer_log = node[:chef][:indexer_log]
  indexer_show_time = "false"
else
  indexer_log = "\"#{node[:chef][:indexer_log]}\""
  indexer_show_time = "true"
end

template "/etc/chef/server.rb" do
  source "server.rb.erb"
  owner "root"
  group "root" 
  mode "644"
  variables(
    :server_log => server_log,
    :show_time  => server_show_time
  )
  notifies :restart, resources(
    :service => "chef-server"
  ), :delayed
end

template "/etc/chef/indexer.rb" do
  source "indexer.rb.erb"
  owner "root"
  group "root" 
  mode "644"
  variables(
    :indexer_log => indexer_log,
    :show_time  => indexer_show_time
  )
  notifies :restart, resources(
    :service => "chef-indexer"
  ), :delayed
end

http_request "compact chef couchDB" do
  action :post
  url "http://localhost:5984/chef/_compact"
  only_if do
    begin
      open("#{Chef::Config[:couchdb_url]}/chef")
      JSON::parse(open("#{Chef::Config[:couchdb_url]}/chef").read)["disk_size"] > 100_000_000
    rescue OpenURI::HTTPError
      nil
    end
  end
end

%w{chef-indexer chef-server}.each do |svc| 
  service svc do
    action [ :enable, :start ]
  end
end
