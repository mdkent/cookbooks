# Allows other cookbooks to carry repo files in templates/repos.d/
# which can be enabled/disabled on demand.

define :yum_repo, :enable => true do
  repo_name = params[:name]
  cb = params[:cookbook]

  if params.has_key?(:template) == false
    tpl = "repos.d/#{repo_name}.repo.erb"
  else
    tpl = params[:template]
  end

  execute "yum_clean_all" do
    command "yum clean all"
    action :nothing
  end

  if params[:enable]
    template "/etc/yum.repos.d/#{repo_name}.repo" do
      source tpl 
      if cb 
        cookbook cb 
      end
      notifies :run, resources(:execute => "yum_clean_all"), :immediately
      owner "root"
      group "root"
      mode 0644
      variables(
        :recipe_name => self.recipe_name,
        :cookbook_name => self.cookbook_name,
        :params => params,
        :repo_name => repo_name
      )
    end
  else
    file "/etc/yum.repos.d/#{repo_name}.repo" do
      action :delete
      notifies :run, resources(:execute => "yum_clean_all"), :immediately
    end
  end
end
