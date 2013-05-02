package "hadoop-hbase" do
    action :install
end

# after this http://localhost:60010 works:
package "hadoop-hbase-master" do
    action :install
end

template "/etc/hbase/conf/hbase-site.xml" do
  source "hbase-site.erb"
  mode 0644
end

# execute "service hbase-master start"