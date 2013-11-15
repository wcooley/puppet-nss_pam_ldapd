require 'spec_helper'

describe 'nss_pam_ldapd::package' do
  it { should contain_package('nss-pam-ldapd').with(:ensure => 'installed') }
end
