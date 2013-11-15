[![Build Status](https://travis-ci.org/wcooley/puppet-nss_pam_ldapd.png?branch=master)](https://travis-ci.org/wcooley/puppet-nss_pam_ldapd)

nss_pam_ldapd
=============

Puppet module for managing the `nss_pam_ldapd` package.

Example
-------

In `hieradata/global.yaml`:

    nss_pam_ldapd::config::ldap:
        uris:
            - ldap://ldap1.example.com
            - ldap://ldap2.example.com
            - ldap://ldap3.example.com
        basedn: dc=pdx,dc=edu
        ssl: start_tls
        tls_cacertdir: /etc/openldap/cacerts
        tls_reqcert: never
        timelimit: 120
        bind_timelimit: 120
        idle_timelimit: 3600

In manifests somewhere:

        include nss_pam_ldapd

Author
-------
* Wil Cooley wcooley(at)nakedape.cc
* Dan Young dmy(at)pdx.edu

License
-------

    Author:: Wil Cooley (wcooley(at)nakedape.cc), Dan Young (dmy(at)pdx.edu)
    Copyright:: Copyright (c) 2013 Wil Cooley, Dan Young
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


Support
-------

Please log tickets and issues at our [Github project][1].

[1]: https://github.com/wcooley/puppet-nss_pam_ldapd/issues
