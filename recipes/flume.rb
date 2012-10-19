package "flume-ng" do
    action :install
end

begin
  template "/etc/flume-ng/conf/flume-hdfs.conf" do
     source "flume.conf.erb"
     mode 0644
   end
  template "/etc/init/flume-hdfs.conf" do
     source "upstart-flume.erb"
     mode 0644
     end
  service "flume-hdfs" do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end
end if node['flume']['installpreconfigured']
