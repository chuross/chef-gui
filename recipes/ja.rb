include_recipe 'gui::default'

if platform?('ubuntu')
	list_name = nil

	version = node['platform_version']
	if version >= '13.10'
		list_name = 'saucy'
	elsif version >= '13.04'
		list_name = 'raring'
	elsif version >= '12.10'
		list_name = 'quantal'
	else
		list_name = 'precise'
	end

	bash 'add-repository' do
		cwd '/tmp'
		code <<-EOH
		wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add -
		wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add -
		wget https://www.ubuntulinux.jp/sources.list.d/#{list_name}.list -O /etc/apt/sources.list.d/ubuntu-ja.list
		apt-get update
		apt-get -y upgrade
		EOH
		creates '/etc/apt/sources.list.d/ubuntu-ja.list'
	end

	%w{language-pack-ja language-pack-ja-base language-pack-gnome-ja ubuntu-defaults-ja}.each do |pkg|
		package pkg do
			action :install
		end
	end

	template '/etc/default/locale' do
		source 'ubuntu-ja.erb'
		action :touch
	end
elsif platform?('centos')
	execute 'japanese support' do
		command 'yum -y groupinstall "Japanese Support"'
	end

	template '/etc/sysconfig/i18n' do
		source 'centos-ja.erb'
		action :touch
	end
end