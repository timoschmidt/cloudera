package "hadoop-hbase" do
    action :install
end

# after this http://localhost:60010 works:
package "hadoop-hbase-master" do
    action :install
end

# execute "service hbase-master start"