class nss_pam_ldapd::config {
  $ldap = hiera('nss_pam_ldapd::config::ldap', {
        uris           => [ 'ldap://localhost', ],
        basedn         => 'dc=example,dc=com',
        ssl            => 'start_tls',
        tls_checkpeer  => 'no',
        tls_cacertdir  => '/etc/openldap/cacerts',
        tls_reqcert    => 'never',
        timelimit      => 120,
        bind_timelimit => 120,
        idle_timelimit => 3600,
      })

  file { '/etc/nslcd.conf':
    content => template('nss_pam_ldapd/nslcd.conf.erb'),
    mode    => '0400',
    owner   => 'root',
    group   => 'root',
  }
}
