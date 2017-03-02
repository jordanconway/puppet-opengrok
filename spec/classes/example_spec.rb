require 'spec_helper'

describe 'opengrok' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "opengrok class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('opengrok::params') }
          it { is_expected.to contain_class('opengrok::install').that_comes_before('opengrok::config') }
          it { is_expected.to contain_class('opengrok::config') }
          it { is_expected.to contain_class('opengrok::service').that_subscribes_to('opengrok::config') }

          it { is_expected.to contain_service('opengrok') }
          it { is_expected.to contain_package('opengrok').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'opengrok class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('opengrok') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
