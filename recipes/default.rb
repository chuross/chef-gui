if platform?('ubuntu')
	execute "apt-get-update" do
		command "apt-get update"
		ignore_failure true
		only_if do
			File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
			File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
		end
	end
	
	package 'ubuntu-desktop' do 
		action :install
	end
else
	Chef::Application.fatal!('not supported on other OS.')
end