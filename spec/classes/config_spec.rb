require 'spec_helper'

describe 'opengrok::config' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        get_opengrok_fname = {}
        before(:each) do
          Puppet::Functions.create_function(:get_opengrok_fname) do
            dispatch :get_opengrok_fname do
              param 'String', :opengrok_url
            end
          end
          get_opengrok_fname.stubs(:getopengrok_fname).returns('opengrok-0.12.1.6')
        end

        context "opengrok::config class with default parameters" do
          let (:params) do
            {
              'projects' => {},
              'opengrok_dir' => '/opt/opengrok',
              'catalina_home' => '/var/lib/tomcat',
              'body_text' => 'Look at my repos, they are simply amazing!',
              'config_hash' => { 'OPENGROK_VERBOSE' => 'no' },
            }
          end

          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_file('/opt/opengrok/bin/OpenGrok').with(
              'ensure'  => 'present',
              'mode'    => '0555',
            ).with_content(/\/var\/lib\/tomcat/)
          end

          it do
            is_expected.to contain_file('/var/opengrok/etc/opengrok.conf').with(
              'ensure'  => 'present',
              'mode'    => '0644',
            ).with_content(/OPENGROK_VERBOSE=no/)
          end

          it do
            is_expected.to contain_file('/var/lib/tomcat/webapps/source/index_body.html').with(
              'ensure'  => 'present',
              'mode'    => '0644',
            ).with_content(/Look at my repos, they are simply amazing!/)
          end

          it do
            is_expected.to contain_exec('opengrok_deploy').with(
              'command' => '/opt/opengrok/bin/OpenGrok deploy',
              'creates' => '/var/lib/tomcat/webapps/source.war'
            ).that_requires('File[/opt/opengrok/bin/OpenGrok]')
          end

          it do
            is_expected.to contain_exec('opengrok_index').with(
              'command' => '/opt/opengrok/bin/OpenGrok index',
              'creates' => '/var/opengrok/etc/configuration.xml'
            ).that_requires('File[/opt/opengrok/bin/OpenGrok]')
          end

          it do
            is_expected.to contain_exec('opengrok_update').with(
              'command' => '/opt/opengrok/bin/OpenGrok update',
              'refreshonly' => 'true'
            ).that_requires('Exec[opengrok_index]')
          end
        end
      end
    end
  end
end
