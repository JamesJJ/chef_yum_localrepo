yum-localrepo Cookbook
======================

Creates and configures a yum repo on disk for use by the local system. Optionally places specified RPMs into the repo.

Many chef cookbooks have package dependencies that are not met by available yum repositories. You could set-up your own yum repo server and configure your systems to use it, or you could just put your RPM files in <cookbook_name>/files/... and use this cookbook.

Requirements
------------

This recipe should stand alone. Your system will need the "createrepo" package available.

Attributes
----------

#### yum-localrepo::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:yum_localrepo][:createrepo_package]</tt></td>
    <td>String</td>
    <td>The package name that includes the createrepo executable on your distro.</td>
    <td><tt>createrepo</tt></td>
  </tr>
  <tr>
    <td><tt>[:yum_localrepo][:yumd_path]</tt></td>
    <td>String</td>
    <td>Directory path where repo configuration files are placed</td>
    <td><tt>/etc/yum.repos.d</tt></td>
  </tr>
  <tr>
    <td><tt>[:yum_localrepo][:files_cookbook]</tt></td>
    <td>String</td>
    <td>The cookbook where RPMs are located</td>
    <td><tt>yum-localrepo</tt></td>
  </tr>
  <tr>
    <td><tt>[:yum_localrepo][:templates_cookbook]</tt></td>
    <td>String</td>
    <td>The cookbook where templates are located</td>
    <td><tt>yum-localrepo</tt></td>
  </tr>
  <tr>
    <td><tt>[:yum_localrepo][:repos]</tt></td>
    <td>Array of "repo" hashes</td>
    <td>List of on disk yum repos to create. The attributes are used to create a yum.repos.d/&lt;name&gt; file using the template <tt>yum_repo.repo.erb</tt>. RPMs listed in <tt>rpms</tt> will be copied from <tt>[:yum_localrepo][:files_cookbook]/files/...</tt> in to the repo</td>
    <td><pre>[
 {
    name: 'yum_local_repo',
    path: '/opt/yum_local_repo',
    enabled: 1,
    gpgcheck: 0,
    protect: 1,
    rpms: [ ]
  }
]</pre></td>
  </tr>
</table>

Usage
-----

Include `yum-localrepo` in your node's `run_list`

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yum-localrepo]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: MIT
Author: JamesJJ
