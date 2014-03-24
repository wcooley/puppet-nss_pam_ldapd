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

  context 'All params non-default' do
    let(:facts) {{ :osfamily => 'redhat' }}

    lp = {
      'uris'           => ['ldap://ldap1.example.com',
                           'ldap://ldap2.example.com' ],
      'basedn'         => 'o=example org,c=us',
      'ssl'            => 'broken',
      'tls_checkpeer'  => 'yes',
      'tls_cacertdir'  => '/etc/pki/tls',
      'tls_reqcert'    => 'always',
      'timelimit'      => '90',
      'bind_timelimit' => '15',
      'idle_timelimit' => '1800',
    }

    let(:params) {{ :ldap => lp }}

    it { should contain_augeas('/etc/nslcd.conf') \
      .with_changes([
                      %Q<set uri '#{lp['uris'].join(' ')}'>,
                      %Q<set basedn '#{lp['basedn']}'>,
                      %Q<set ssl '#{lp['ssl']}'>,
                      %Q<set tls_checkpeer '#{lp['tls_checkpeer']}'>,
                      %Q<set tls_cacertdir '#{lp['tls_cacertdir']}'>,
                      %Q<set tls_reqcert '#{lp['tls_reqcert']}'>,
                      %Q<set timelimit '#{lp['timelimit']}'>,
                      %Q<set bind_timelimit '#{lp['bind_timelimit']}'>,
                      %Q<set idle_timelimit '#{lp['idle_timelimit']}'>,
      ])
    }

  end
end
