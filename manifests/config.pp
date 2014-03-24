class nss_pam_ldapd::config (
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
      }),
  $template = 'nss_pam_ldapd/nslcd.conf.erb'
  ) {

  $ldap_uri_val = join($ldap['uris'], ' ')

  $augeas_changes = [
      "set uri '${ldap_uri_val}'",
      "set basedn '${ldap[basedn]}'",
      "set ssl '${ldap[ssl]}'",
      "set tls_checkpeer '${ldap[tls_checkpeer]}'",
      "set tls_cacertdir '${ldap[tls_cacertdir]}'",
      "set tls_reqcert '${ldap[tls_reqcert]}'",
      "set timelimit '${ldap[timelimit]}'",
      "set bind_timelimit '${ldap[bind_timelimit]}'",
      "set idle_timelimit '${ldap[idle_timelimit]}'",
  ]

  file { '/etc/nslcd.conf':
    mode    => '0400',
    owner   => 'root',
    group   => 'root',
  }

  augeas { '/etc/nslcd.conf':
    lens    => 'Spacevars.lns',
    incl    => '/etc/nslcd.conf',
    changes => $augeas_changes,
  }
}
