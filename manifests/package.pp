class nss_pam_ldapd::package {
  case $::osfamily {
    redhat: { $packages = ['nss-pam-ldapd'] }
    debian: { $packages = ['libpam-ldapd', 'libnss-ldapd', 'libpam-runtime'] }
  }


  package { $packages:
    ensure => installed,
  }
}
