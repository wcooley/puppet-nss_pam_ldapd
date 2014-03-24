class nss_pam_ldapd::config (
  $ldap = hiera('nss_pam_ldapd::config::ldap', {
        uri           => [ 'ldap://localhost', ],
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

  if has_key($ldap, 'uri') {
    $ldap_uri_val = is_array($ldap['uri']) ? {
          true    => join($ldap['uri'], ' '),
          default => $ldap['uri'],
      }
  }
  elsif has_key($ldap, 'uris') {

    warning("${name} param 'uris' is deprecated; use 'uri' instead")
    $ldap_uri_val = is_array($ldap['uris']) ? {
          true    => join($ldap['uris'], ' '),
          default => $ldap['uris'],
      }
  }

  if $ldap_uri_val {
    $aug_uri = "set uri '${ldap_uri_val}'"
  }
  else {
    $aug_uri = undef
  }

  $aug_basedn = has_key($ldap, 'basedn') ? {
        true => "set basedn '${ldap['basedn']}'",
        default => undef,
      }

  $aug_ssl = has_key($ldap, 'ssl') ? {
        true    => "set ssl '${ldap['ssl']}'",
        default => undef,
      }

  $aug_tls_checkpeer = has_key($ldap, 'tls_checkpeer') ? {
        true => "set tls_checkpeer '${ldap['tls_checkpeer']}'",
        default => undef,
      }

  $aug_tls_cacertdir = has_key($ldap, 'tls_cacertdir') ? {
        true    => "set tls_cacertdir '${ldap['tls_cacertdir']}'",
        default => undef,
      }

  $aug_tls_reqcert = has_key($ldap, 'tls_reqcert') ? {
        true    => "set tls_reqcert '${ldap['tls_reqcert']}'",
        default => undef,
      }

  $aug_timelimit = has_key($ldap, 'timelimit') ? {
        true    => "set timelimit '${ldap['timelimit']}'",
        default => undef,
      }

  $aug_bind_timelimit = has_key($ldap, 'bind_timelimit') ? {
        true    => "set bind_timelimit '${ldap['bind_timelimit']}'",
        default => undef,
      }

  $aug_idle_timelimit = has_key($ldap, 'idle_timelimit') ? {
        true    => "set idle_timelimit '${ldap['idle_timelimit']}'",
        default => undef,
      }

  $augeas_changes = grep([
      $aug_uri,
      $aug_basedn,
      $aug_ssl,
      $aug_tls_checkpeer,
      $aug_tls_cacertdir,
      $aug_tls_reqcert,
      $aug_timelimit,
      $aug_bind_timelimit,
      $aug_idle_timelimit,
  ], '.')

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
