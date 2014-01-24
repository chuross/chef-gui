if platform?('ubuntu')
	execute "apt-get-update" do
		command "apt-get update"
	end
	
	package 'ubuntu-desktop' do 
		action :install
	end
else
	Chef::Application.fatal!('No supported on other OS.')
end