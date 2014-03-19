require 'spec_helper'

describe 'nss_pam_ldapd::package', :type => 'class' do
    context "On Debian" do
        let :facts do
        {
            :osfamily => 'Debian'
        }
        end
        it { 
            should contain_package('libnss-ldapd').with(:ensure => 'installed')
            should contain_package('libpam-ldapd').with(:ensure => 'installed')
            should contain_package('libpam-runtime').with(:ensure => 'installed')
        }
    end

    context "On Redhat" do
        let :facts do
        {
            :osfamily => 'RedHat'
        }
        end
        it { 
            should contain_package('nss-pam-ldapd').with(:ensure => 'installed') 
        }
    end
end
