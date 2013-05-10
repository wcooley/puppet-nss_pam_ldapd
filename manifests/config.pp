class nss_pam_ldapd::config {
  file { '/etc/nslcd.conf':
    content => template('nss_pam_ldapd/nslcd.conf.erb'),
    mode    => '0400',
    owner   => 'root',
    group   => 'root',
  }
}
