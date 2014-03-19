class nss_pam_ldapd::package {
  include nss_pam_ldapd::params

  package { $nss_pam_ldapd::params::packages:
    ensure => installed,
  }
}
