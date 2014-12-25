default[:yum_localrepo][:createrepo_package] = 'createrepo'
default[:yum_localrepo][:yumd_path] = '/etc/yum.repos.d'
default[:yum_localrepo][:templates_cookbook] = nil
default[:yum_localrepo][:files_cookbook] = nil
default[:yum_localrepo][:repos] = [ 
  {
  name: 'yum_local_repo',
  path: '/opt/yum_localrepo',
  enabled: 1,
  gpgcheck: 0,
  protect: 1,
  rpms: [ ]
  }
]

