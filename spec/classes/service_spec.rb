require 'spec_helper'

describe 'opengrok::service' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "opengrok::service class with default parameters" do
          let (:params) do
            {
              'service_name' => 'tomcat',
            }
          end

          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_service('tomcat').with(
              'ensure'     => 'running',
              'enable'     => 'true',
              'hasstatus'  => 'true',
              'hasrestart' => 'true',
            )
          end
        end
      end
    end
  end
end
