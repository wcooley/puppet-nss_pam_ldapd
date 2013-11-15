require 'spec_helper'

describe 'nss_pam_ldapd::service' do
  it { should contain_service('nslcd').with({
      :ensure => 'running',
      :hasstatus => 'true',
      :hasrestart => 'true',
    })
  }
end
