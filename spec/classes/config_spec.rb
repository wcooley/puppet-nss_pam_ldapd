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

    it { should contain_augeas('/etc/nslcd.conf') \
      .with_changes([
                      %q{set uri 'ldap://localhost'},
                      %q{set basedn 'dc=example,dc=com'},
                      %q{set ssl 'start_tls'},
                      %q{set tls_checkpeer 'no'},
                      %q{set tls_cacertdir '/etc/openldap/cacerts'},
                      %q{set tls_reqcert 'never'},
                      %q{set timelimit '120'},
                      %q{set bind_timelimit '120'},
                      %q{set idle_timelimit '3600'}
      ])
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
