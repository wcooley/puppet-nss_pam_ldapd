class nss_pam_ldapd::service {
  service { 'nslcd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}
