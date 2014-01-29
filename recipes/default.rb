if platform?('ubuntu')
	execute "apt-get-update" do
		command "apt-get update"
	end

	package 'ubuntu-desktop' do
		action :install
	end
elsif platform?('centos')
	execute "install desktop" do
		command 'yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts"'
	end

	execute "install desktop" do
		command 'sed -i "s/id:3:initdefault:/id:5:initdefault:/g" /etc/inittab'
	end
else
	Chef::Application.fatal!('No supported on other OS.')
end