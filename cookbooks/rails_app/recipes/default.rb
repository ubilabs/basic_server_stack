include_recipe "passenger_apache2"

execute "disable apache default site" do
  command "a2dissite default"
  notifies :reload, resources(:service => "apache2")
end

web_app "testproj" do
  cookbook "passenger_apache2"
  docroot "/var/www/testproj/public"
  server_name "#{node[:hostname]}.#{node[:domain]}"
  server_aliases [ node[:hostname] ]
  rails_env "production"
end
