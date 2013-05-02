
execute "curl -s http://archive.cloudera.com/debian/archive.key | sudo apt-key add -"

case node[:platform]
    when "ubuntu"
        case node[:lsb][:codename]
            when "lucid"
                execute "wget http://archive.cloudera.com/one-click-install/lucid/cdh3-repository_1.0_all.deb"
            when "squeeze"
                execute "wget http://archive.cloudera.com/one-click-install/squeeze/cdh3-repository_1.0_all.deb"
            when "maverick"
                execute "wget http://archive.cloudera.com/one-click-install/maverick/cdh3-repository_1.0_all.deb"
         end
         execute "dpkg -i cdh3-repository_1.0_all.deb"
         execute "apt-get update"
end



package "hadoop-0.20-conf-pseudo" do
   action :install
end


# copy over helper script to start hdfs
cookbook_file "/tmp/hadoop-hdfs-start.sh" do
    source "hadoop-hdfs-start.sh"
    mode "0744"
end
cookbook_file "/tmp/hadoop-hdfs-stop.sh" do
    source "hadoop-hdfs-stop.sh"
    mode "0744"
end
cookbook_file "/tmp/hadoop-0.20-mapreduce-start.sh" do
    source "hadoop-0.20-mapreduce-start.sh"
    mode "0744"
end
cookbook_file "/tmp/hadoop-0.20-mapreduce-stop.sh" do
    source "hadoop-0.20-mapreduce-stop.sh"
    mode "0744"
end
cookbook_file "/tmp/prepare-0.20-mapreduce.sh" do
    source "prepare-0.20-mapreduce.sh"
    mode "0777"
end


# only for the first run we need to format as hdfs (we pass input "N" to answer the reformat question with No )
################
execute "format namenode" do
    command 'echo "N" | hadoop namenode -format'
    user "hdfs"
    returns [0,1]
end


# Jobtracker repeats - was the only way to get both together
%w{jobtracker tasktracker}.each { |name|
  service "hadoop-0.20-#{name}" do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end
}

# now hadopp should run and this should work: http://localhost:50070:
%w(datanode namenode secondarynamenode).each { |name|
  service "hadoop-0.20-#{name}" do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end
}

# Prepare folders (only first run)
# TODO: only do this if "hadoop fs -ls /tmp" return "No such file or directory"
################

execute "/tmp/prepare-0.20-mapreduce.sh" do
  user "hdfs"
  not_if 'hadoop fs -ls -R / | grep "/var/lib/hadoop-hdfs/cache/mapred"'
end
