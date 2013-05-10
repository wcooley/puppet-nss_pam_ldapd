class nss_pam_ldapd {
  include nss_pam_ldapd::package
  include nss_pam_ldapd::config
  include nss_pam_ldapd::service

  Class['nss_pam_ldapd::package']
    -> Class['nss_pam_ldapd::config']
    ~> Class['nss_pam_ldapd::service']
}
