# frozen_string_literal: true

require 'spec_helper'

describe 'sudo' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
  context 'on freebsd' do
    let(:facts) do
      {
        os: {
          family: 'FreeBSD',
        }
      }
    end

    it { is_expected.to compile }
    it do
      is_expected.to contain_file('/usr/local/etc/sudoers').with(
                       'owner' => 'root',
                       'group' => 'wheel',
                       'mode'  => '0440',
                     ).with_content(%r{^root ALL = \(ALL\)  ALL$})
    end
  end
  context 'with defaults for all parameters' do
    it { is_expected.to contain_file('/etc/sudoers') }
    it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^#includedir /etc/sudoers.d$}) }
  end
  context 'with use_includedir=false' do
    let(:params) do
      { use_includedir: false }
    end

    it { is_expected.to contain_file('/etc/sudoers').without_content(%r{^#includedir}) }
  end
  context 'with manage_sudoers=false' do
    let(:params) do
      { manage_sudoers: false }
    end

    it { is_expected.not_to contain_file('/etc/sudoers') }
  end
  context 'with some config' do
    let(:params) do
      {
        conf: {
          _sudoers: {
            "defaults": [
              {
                "Defaults": [
                  'syslog=auth',
                ]
              },
              {
                "Defaults>root": [
                  '!set_logname',
                ]
              },
              {
                "Defaults:FULLTIMERS": [
                  '!lecture',
                ]
              },
              {
                "Defaults:millert": [
                  '!authenticate',
                ]
              },
              {
                "Defaults@SERVERS": [
                  'log_year',
                  'logfile=/var/log/sudo.log',
                ]
              },
              {
                "Defaults!PAGERS": [
                  'noexec',
                ]
              },
            ],
            user_alias: {
              FULLTIMERS: [
                'millert',
                'mikef',
                'dowdy',
              ],
            },
            runas_alias: {
              ADMINGRP: [
                'adm',
                'oper',
              ],
            },
            host_alias: {
              SGI: [
                'grolsch',
                'dandelion',
                'black',
              ],
            },
            cmnd_alias: {
              PRINTING: [
                '/usr/sbin/lpc',
                '/usr/bin/lprm',
              ],
            },
            user_specs: [
              {
                commands: [
                  '/bin/id',
                ],
                users: [
                  'millert',
                  'mikef',
                ],
               hosts: [
                 'bigtime',
                 'eclipse',
               ]
              },
            ]
          },
          george: {
            "defaults": [
              {
                "Defaults": [
                  'always_set_home',
                  'env_reset',
                  'noexec',
                ]
              },
            ],
            user_specs: [
              commands: [
                '/bin/id',
              ],
              users: [
                'millert',
              ],
              hosts: [
                'bigtime',
              ],
            ]
          },
        }
      }
    end

    it { is_expected.to contain_file('/etc/sudoers.d/george') }
    it {
      is_expected.to contain_file('/etc/sudoers.d/george')
        .without_content(%r{^#includedir /etc/sudoers.d$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^User_Alias FULLTIMERS = millert, mikef, dowdy$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^Runas_Alias ADMINGRP = adm, oper$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^Host_Alias SGI = grolsch, dandelion, black$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^Cmnd_Alias PRINTING = /usr/sbin/lpc, /usr/bin/lprm$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^Defaults syslog=auth$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^Defaults>root !set_logname$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^Defaults:FULLTIMERS !lecture$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^Defaults:millert !authenticate$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^Defaults@SERVERS log_year, logfile=/var/log/sudo.log$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^Defaults!PAGERS noexec$})
    }
    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^millert,mikef bigtime,eclipse =  /bin/id$})
    }
    context 'with use_includedir=false' do
      let(:params) do
        super().merge({ 'use_includedir' => false })
      end

      it { is_expected.to compile.and_raise_error(%r{Evaluation Error}) }
    end
  end
end
