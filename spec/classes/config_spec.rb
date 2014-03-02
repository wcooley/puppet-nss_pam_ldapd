require 'spec_helper'
require 'hiera-puppet'

describe 'nss_pam_ldapd::config' do
  context 'default' do
    it { should contain_file('/etc/nslcd.conf').with({
        :mode => '0400',
        :owner => 'root',
        :group => 'root',
      })\
      .with_content(/^uri ldap:\/\/localhost$/)\
      .with_content(/^base dc=example,dc=com$/)\
      .with_content(/^ssl start_tls$/)\
    }
  end

  context 'non-default' do
    let(:params) do {
        :ldap => {
          'uris' => ['ldap://ldap1.example.com', 'ldap://ldap2.example.com' ],
          'basedn' => 'o=example org,c=us',
          'ssl' => 'broken',
          'tls_reqcert' => 'always',
        }
      }
    end

    it {
      should contain_file('/etc/nslcd.conf').with({
        :mode => '0400',
        :owner => 'root',
        :group => 'root',
      })\
      .with_content(/^uri ldap:\/\/ldap1\.example\.com ldap:\/\/ldap2\.example\.com$/)\
      .with_content(/^base o=example org,c=us$/)\
      .with_content(/^ssl broken$/)\
      .with_content(/^tls_reqcert always$/)
    }

  end
end
