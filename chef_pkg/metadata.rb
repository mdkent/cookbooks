maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Configures and maintains chef client and server installs previously installed via distribution packages"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version           "0.1"
recipe            "chef_pkg::client", "Configures a Chef client installed from packages"
recipe            "chef_pkg::server", "Configures a Chef server installed from packages"
recipe            "chef_pkg::server_proxy", "Configures an Apache SSL proxy in front of your chef-server"

%w{ apache2 }.each do |cb|
  depends cb
end

%w{ centos rhel ubuntu debian }.each do |os|
  supports os
end

attribute "chef/url_type",
  :display_name => "URL Type",
  :description => "Type of URL to use when referencing the chef server in config templates",
  :default => "http"

attribute "chef/path",
  :display_name => "Chef Path",
  :description => "Filesystem location for Chef files",
  :default => "/var/lib/chef"

attribute "chef/run_path",
  :display_name => "Chef Run Path",
  :description => "Filesystem location for Chef 'run' files",
  :default => "/var/run/chef"

attribute "chef/cache_path",
  :display_name => "Chef Cache Path",
  :description => "Filesystem location for Chef 'cache' files",
  :default => "/var/cache/chef"

attribute "chef/serve_path",
  :display_name => "Chef Serve Path",
  :description => "Filesystem location for Chef 'srv' files",
  :default => "/srv/chef"

attribute "chef/client_interval",
  :display_name => "Chef Client Interval",
  :description => "Poll chef client process to run on this interval in seconds",
  :default => "1800"

attribute "chef/client_splay",
  :display_name => "Chef Client Splay",
  :description => "Random number of seconds to add to interval",
  :default => "20"

attribute "chef/log_path",
  :display_name => "Chef Log Path",
  :description => "Filesystem location for Chef 'log' files",
  :default => "/var/log/chef"

attribute "chef/client_log",
  :display_name => "Chef Client Log",
  :description => "Location of the Chef client log",
  :default => "STDOUT"

attribute "chef/indexer_log",
  :display_name => "Chef Indexer Log ",
  :description => "Location of the Chef indexer log",
  :default => "/var/log/chef/indexer.log"


attribute "chef/server_log",
  :display_name => "Chef Server Log",
  :description => "Location of the Chef server log",
  :default => "/var/log/chef/server.log"

attribute "chef/server_fqdn",
  :display_name => "Chef Server Fully Qualified Domain Name",
  :description => "FQDN of the Chef server for Apache vhost and SSL certificate and clients",
  :default => "fqdn"

attribute "chef/server_token",
  :display_name => "Chef Server Validation Token",
  :description => "Value of the validation_token",
  :default => "randomly generated"

attribute "chef/server_ssl_req", 
  :display_name => "Chef Server SSL Request",
  :description => "Data to pass for creating the SSL certificate",
  :default => "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/CN=chef_server_fqdn/emailAddress=ops@domain"
