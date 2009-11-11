#
# Author:: Joshua Timberman <joshua@opscode.com>
# Cookbook Name:: chef_pkg
# Attributes:: chef
#
# Copyright 2008-2009, Opscode, Inc
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

validation_token = ""
chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
20.times { |i| validation_token << chars[rand(chars.size-1)] }

default.chef.url_type   = "http"

default.chef.path       = "/var/lib/chef"
default.chef.run_path   = "/var/run/chef"
default.chef.cache_path = "/var/cache/chef"
default.chef.serve_path = "/srv/chef"

default.chef.client_interval = "1800"
default.chef.client_splay    = "20"
default.chef.log_path        = "/var/log/chef"

# You can change or override these to STDOUT if you plan on running them in the
# foreground.
default.chef.client_log  = "STDOUT"
default.chef.indexer_log = "#{chef[:log_path]}/indexer.log"
default.chef.server_log  = "#{chef[:log_path]}/server.log"

default.chef.server_fqdn     = fqdn
default.chef.server_token    = validation_token
default.chef.server_ssl_req  = "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/" +
  "CN=#{chef[:server_fqdn]}/emailAddress=ops@#{domain}"
