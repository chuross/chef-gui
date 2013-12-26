include_recipe 'chef-gui::default'

if platform?('ubuntu')
	bash 'add-repository' do
		cwd '/tmp'
		code <<-EOH
		wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add -
        wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add -
        wget https://www.ubuntulinux.jp/sources.list.d/raring.list -O /etc/apt/sources.list.d/ubuntu-ja.list
        apt-get update
        apt-get -y upgrade
		EOH
		creates '/etc/apt/sources.list.d/ubuntu-ja.list'
	end

	package 'ubuntu-defaults-ja' do
		action :install
	end

	template '/etc/default/locale' do
		source 'locale-ja.erb'
		action :touch
	end
else
	Chef::Application.fatal!('No supported on other OS.')
end