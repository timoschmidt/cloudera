
if node[:platform] == "ubuntu"
    execute "apt-get update"
end

# Install required base packages
package "curl" do
    action :install
end

package "wget" do
    action :install
end

include_recipe "cloudera::cloudera#{node['cloudera']['version']}"
