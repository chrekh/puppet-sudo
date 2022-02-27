# frozen_string_literal: true

require 'spec_helper'

describe 'sudo' do
  it { is_expected.to compile }
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
  context 'with some config' do
    let(:params) do
      {
        conf: {
          _sudoers: {
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
            }
          }
        }
      }
    end

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
  end
end
