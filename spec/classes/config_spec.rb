require 'spec_helper'

describe 'nss_pam_ldapd::config' do
  context 'Red Hat defaults' do
    let(:facts) {{ :osfamily => 'RedHat' }}

    it { should contain_file('/etc/nslcd.conf').with({
        :mode => '0400',
        :owner => 'root',
        :group => 'root',
      })
    }

    }
  end

  context 'non-default' do
    let(:facts) {{ :osfamily => 'RedHat' }}

    let(:params) do {
        :ldap => {
          'uris' => ['ldap://ldap1.example.com', 'ldap://ldap2.example.com' ],
          'basedn' => 'o=example org,c=us',
          'ssl' => 'broken',
          'tls_reqcert' => 'always',
        }
      }
    end

    it { should contain_file('/etc/nslcd.conf') \
        .with_mode('0400')  \
        .with_owner('root') \
        .with_group('root')
    }

  end
end
