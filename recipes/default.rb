#
# Cookbook Name:: yum-localrepo
# Recipe:: default
#
# Copyright 2014, JamesJJ
#
# MIT License
#


package node[:yum_localrepo][:createrepo_package] do
  action :install
  not_if do node[:yum_localrepo][:createrepo_package].nil? end
end

_yumd = node[:yum_localrepo][:yumd_path]
node[:yum_localrepo][:repos].each do |_repo|
  _name = _repo[:name]
  _path = _repo[:path]
  _rpms = _repo[:rpms]
  _enabled = _repo[:enabled]
  _gpgcheck = _repo[:gpgcheck]
  _protect = _repo[:protect]
  _safename = _path.to_s.gsub(/[^a-z0-9_\.\-]+/i, '_')
  [ _path, File.join(_path,'RPMS') ].each do |_dir|
    directory _dir do
      mode '0755'
      owner 'root'
      group 'root'
    end
  end
  _rpms.each do |_rpm|
    cookbook_file File.join(_path,'RPMS',_rpm) do
      mode '0644'
      owner 'root'
      group 'root'
    end
  end
  execute "Creating Repo in #{_path}" do
    command "createrepo #{_path}"
    environment "PATH" => "/usr/bin:/bin:/usr/sbin:/sbin"
  end
  template File.join(_yumd,"#{_safename}.repo" do
    cookbook node[:yum_localrepo][:yumd_cookbook] unless node[:yum_localrepo][:yumd_cookbook].nil?
    source 'yum_repo.repo.erb'
    mode '0644'
    owner 'root'
    group 'root'
    variables :name => _name, :path => _path, :safename => _safename, :enabled => _enabled, :gpgcheck => _gpgcheck, :protect => _protect
  end
end

