Vagrant::Config.run do |config|
  # use the previously added ubuntu box
  config.vm.box = "precise32"

  # node default port is 3000, fwd it to localhost:8080
  config.vm.forward_port 3000, 8080 

  # fix some us.archive.ubuntu.com issues
  #config.vm.provision :shell, :inline => "apt-get clean; apt-get update" 

  config.vm.provision :chef_solo do |chef|
    chef.json = {
        "gitnodesite" => {
          "name" => "node ",
          "web_root" => "/var/www_git-node-site"
        }
      }

    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.add_recipe "git-node-site"
  end
end
