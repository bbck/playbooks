Vagrant.configure(2) do |config|
  config.vm.box = "debian/jessie64"

  role_files = Dir['*.yml']
  role_files.delete 'site.yml'

  role_files.each do |file|
    role_name = file.gsub('.yml', '')
    config.vm.define role_name do |role|
      role.vm.hostname = role_name

      role.vm.provider "virtualbox" do |vbox|
        vbox.name = role_name
      end

      role.vm.provision "ansible" do |ansible|
        ansible.playbook = file
        ansible.verbose = "v"
        ansible.ask_vault_pass = true
      end
    end
  end
end
