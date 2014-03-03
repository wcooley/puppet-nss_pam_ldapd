class nss_pam_ldapd::package {
  case $::osfamily {
    redhat: { $packages = ['nss-pam-ldapd'] }
    debian: { $packages = ['libpam-ldapd', 'libnss-ldapd', 'libpam-runtime'] }
    default: { fail("${::osfamily} is not supported by this module") }
  }


  package { $packages:
    ensure => installed,
  }
}
