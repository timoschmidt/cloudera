Description
===========

Installs Cloudera Pseudo according to the description on the website of Cloudera.
( https://ccp.cloudera.com/display/CDH4DOC/Installing+CDH4+on+a+Single+Linux+Node+in+Pseudo-distributed+Mode#InstallingCDH4onaSingleLinuxNodeinPseudo-distributedMode-InstallingCDH4withYARNonaSingleLinuxNodeinPseudodistributedmode )

Requires the java cookbook as well: https://github.com/opscode-cookbooks/java



Cookbooks
===========================
* cloudera (default) - Installs cloudera in the Pseudo mode (all on one) and runs hadoop
* cloudera::flume - Installs flume
* cloudera::hbase - Installs hbase


How to use
===========================


Its best to install with the current role definition. Create a file roles/cloudera.rb

    name "cloudera"
    description "Install Oracle Java on Ubuntu and Cloudera"

    default_attributes(
      :java => {
         :oracle => {
           "accept_oracle_download_terms" => true
         },
         "remove_deprecated_packages" => false
       }
    )

    override_attributes(
      "java" => {
        "install_flavor" => "oracle"
      },
      "cloudera" => {
        "installyarn" => false
      }
    )


    # todo - replace basic by aoe common recipe
    run_list(
        "recipe[java]",
        "recipe[cloudera]",
        "recipe[cloudera::flume]",
        "recipe[cloudera::hbase]"
    )

You may want to use it with a Vagrant vbox. Create a Vagrantfile like this:

    # -*- mode: ruby -*-
    # vi: set ft=ruby :
    Vagrant::Config.run do |config|
        config.vm.box = "precise64"

        config.vm.box_url = "http://files.vagrantup.com/precise64.box"



        config.vm.network :hostonly, "192.168.33.10"

        config.vm.provision :chef_solo do |chef|
           chef.cookbooks_path = "cookbooks"
           chef.roles_path = "roles"
           chef.add_role "cloudera"
         end

      #   chef.validation_client_name = "ORGNAME-validator"
      config.vm.customize ["modifyvm", :id,"--memory", "2048"]
    end

Requirements
============

Platform
--------

* Ubuntu

Attributes
==========

See `attributes/default.rb` for default values.

* `default['cloudera']['installyarn']` (defaults to false, set to true if you want to try the new YARN and MR2)


Run a Map Reduce example
=========================
    sudo su hdfs
    hadoop fs -put Test.txt /tmp
    hadoop jar /usr/lib/hadoop-0.20-mapreduce/hadoop-examples.jar wordcount /tmp/Test.txt /tmp/TestOut3
    hadoop fs -text /tmp/TestOut/part-r-00000
