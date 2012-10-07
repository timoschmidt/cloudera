Description
===========

Installs Cloudera Pseudo according to the description on the website of Cloudera.
Requires Java



Use Role roles/cloudera.rb
===========================

Its best to install with the current role definition

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
        "recipe[cloudera::flume]"
    )



Requirements
============

Platform
--------

* Ubuntu

Attributes
==========

See `attributes/default.rb` for default values.

* default['cloudera']['installyarn'] (defaults to false, set to true if you want to try the new YARN and MR2)


Run a Map Reduce example
=========================
    sudo su hdfs
    hadoop fs -put Test.txt /tmp
    hadoop jar /usr/lib/hadoop-0.20-mapreduce/hadoop-examples.jar wordcount /tmp/Test.txt /tmp/TestOut3
    hadoop fs -text /tmp/TestOut/part-r-00000
