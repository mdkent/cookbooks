include_recipe "packages"

if platform?("centos") && node[:platform_version].to_f > 5.0
  %w{
    yum-allowdowngrade
    yum-changelog
    yum-downloadonly
    yum-fastestmirror
    yum-kernel-module
    yum-kmod
    yum-tsflags
    yum-updateonboot
    yum-utils
    yum-versionlock
  }.each do |p|
    package p do
      action :install 
    end
  end
end

template "/etc/yum.conf" do
  source "yum.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
