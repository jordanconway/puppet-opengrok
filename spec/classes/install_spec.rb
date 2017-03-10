require 'spec_helper'

describe 'opengrok::install' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "opengrok::install class with default parameters" do
          let (:params) do
            {
              'install_ctags' => true,
              'ctags_package' => 'ctags',
              'manage_tomcat' => true,
              'manage_git' => true,
            }
          end

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_file('/var/opengrok/').with('ensure' => 'directory') }
          it { is_expected.to contain_file('/var/opengrok/src').with('ensure' => 'directory') }
          it { is_expected.to contain_file('/var/opengrok/data').with('ensure' => 'directory') }
          it { is_expected.to contain_file('/var/opengrok/etc').with('ensure' => 'directory') }
          it { is_expected.to contain_package('ctags').with('ensure' => 'present') }
        end
      end
    end
  end
end
