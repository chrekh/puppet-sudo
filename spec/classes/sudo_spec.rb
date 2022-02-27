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
  context 'with some user_aliaes' do
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
            }
          }
        }
      }
    end

    it {
      is_expected.to contain_file('/etc/sudoers')
        .with_content(%r{^User_Alias FULLTIMERS = millert, mikef, dowdy$})
    }
  end
end
