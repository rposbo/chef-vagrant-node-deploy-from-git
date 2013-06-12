# create the root web directory
directory "#{node.gitnodesite.web_root}" do
	mode 0755
end

# get the application to install from the git repo
include_recipe "git"

git "#{node.gitnodesite.web_root}" do
  repository "https://github.com/rposbo/basic-node-web-server"
  reference "master"
  action :sync
end

# install nodejs to run the application we just downloaded
package "nodejs" do
	action :install
end

package "npm" do
	action :install
end

# npm seems to need g++/c++/cxx for compilation/make-ing of npm packages
package "build-essential" do
	action :install
end

# download 'forever' to run node as a daemon, then run node pointing at our app.js
bash "start node app" do
	code <<-EOH
		sudo npm install -g forever
		forever start #{node.gitnodesite.web_root}/app.js
	EOH
end
