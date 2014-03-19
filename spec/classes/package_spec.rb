require 'spec_helper'

describe 'nss_pam_ldapd::package' do
  context 'redhat' do
    let(:facts) {{ :osfamily => 'RedHat' }}
    it { should contain_package('nss-pam-ldapd').with(:ensure => 'installed') }
  end

  context 'debian' do
    let(:facts) {{ :osfamily => 'Debian' }}
    it { should contain_package('nslcd').with(:ensure => 'installed') }
  end

  context 'unsupported OS' do
    let(:facts) {{ :osfamily => 'Flibitty Flim-Flam' }}
    it do
      expect {
        should contain_package('nss-pam-ldapd').with_ensure('installed')
      }.to raise_error(Puppet::Error, /error=not_configured/)
    end
  end
end
