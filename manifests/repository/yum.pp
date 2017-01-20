class curator::repository::yum (
  String $rhel_major_release = $::os['release']['major'],
  String $version            = $::curator::repository::version,
) inherits curator::repository {

  yumrepo { 'curator':
    descr    => 'CURATOR REPOSITORY',
    baseurl  => "http://packages.elastic.co/curator/${version}/centos/${rhel_major_release}",
    gpgcheck => 1,
    gpgkey   => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
    enabled  => 1,
  }
}
