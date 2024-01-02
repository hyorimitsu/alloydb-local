# -*- mode: ruby -*-
# vi: set ft=ruby :

## Plugin constraint
unless Vagrant.has_plugin?("vagrant-hostsupdater")
    raise 'Missing plugin `vagrant-hostsupdater`! Install it by `vagrant plugin install vagrant-hostsupdater` command before vagrant up.'
end

## VM config
$HOST   = "alloydb.localhost.com"
$IP     = "192.168.59.170"
$MEMORY = "4096"
$CPUS   = 2

Vagrant.configure("2") do |config|
    config.vm.box = "debian/bookworm64"
    config.vm.hostname = $HOST
    config.vm.network :private_network, ip: $IP

    config.vm.provider :virtualbox do |virtualbox|
        virtualbox.memory = $MEMORY
        virtualbox.cpus = $CPUS
    end

    config.vm.provision "shell", inline: <<-SHELL
        # Install dependencies
        apt-get update
        apt-get -y install \
            ca-certificates \
            curl \
            gnupg \
            lsb-release

        # Install docker
        mkdir -m 0755 -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt-get update
        apt-get -y install \
            docker-ce \
            docker-ce-cli \
            containerd.io

        # Install alloydb-cli
        curl https://asia-apt.pkg.dev/doc/repo-signing-key.gpg | sudo apt-key add -
        apt-get update
        echo "deb https://asia-apt.pkg.dev/projects/alloydb-omni alloydb-omni-apt main" | sudo tee -a /etc/apt/sources.list.d/artifact-registry.list
        apt-get update
        apt-get -y install alloydb-cli

        # Install AlloyDB Omni server software
        mkdir /data
        sudo alloydb database-server install --data-dir=/data

        # Launch AlloyDB Omni server (Confirmation)
        sudo alloydb database-server start
        sudo alloydb database-server stop

        # Setup PostgreSQL
        cd /var/alloydb/config
        sudo cp -p pg_hba.conf pg_hba.conf.org
        echo "host all all 0.0.0.0/0 md5" | sudo tee -a pg_hba.conf
    SHELL
end
