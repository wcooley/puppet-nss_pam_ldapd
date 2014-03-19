#
# == Class: nss_pam_ldapd::params
#
# General parameters for *nss_pam_ldapd*.
#
class nss_pam_ldapd::params {
  case $::osfamily {
    redhat: {
      $packages = [ 'nss-pam-ldapd' ]
    }
    debian: {
      $packages = [ 'nslcd' ]
    }
    default: {
      fail_unconfigured()
    }
  }
}
