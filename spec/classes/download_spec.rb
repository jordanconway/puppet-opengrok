require 'spec_helper'

describe 'opengrok::download' do
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

        context "opengrok::download class with default parameters" do
          let (:params) do
            {
              'download_url' => 'https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip',
              'opengrok_dir' => '/opt/opengrok',
            }
          end

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_file('/opt/opengrok-0.12.1.6').with('ensure' => 'directory') }

          it do
            is_expected.to contain_file('/opt/opengrok').with(
              'ensure' => 'link',
              'target' => '/opt/opengrok-0.12.1.6'
            ).that_requires('File[/opt/opengrok-0.12.1.6]')
          end

          it do
            is_expected.to contain_archive('/tmp/opengrok-0.12.1.6.tar.gz.zip').with(
              'ensure'       => 'present',
              'extract'      => 'true',
              'extract_path' => '/tmp',
              'source'       => 'https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip',
              'creates'      => '/tmp/opengrok-0.12.1.6.tar.gz',
              'cleanup'      => 'true',
            ).that_requires('File[/opt/opengrok-0.12.1.6]')
          end

          it do
            is_expected.to contain_archive('/tmp/opengrok-0.12.1.6.tar.gz').with(
              'ensure'          => 'present',
              'extract'         => 'true',
              'extract_path'    => '/opt/opengrok-0.12.1.6',
              'extract_command' => 'tar xfz %s --strip-components=1',
              'creates'         => '/opt/opengrok-0.12.1.6/bin',
              'cleanup'         => 'true',
            ).that_requires('File[/opt/opengrok-0.12.1.6]')
          end
        end

        context "opengrok::download class with a non-zipped download_url" do
          let (:params) do
            {
              'download_url' => 'https://github.com/OpenGrok/OpenGrok/releases/download/0.13-rc10/opengrok-0.13-rc10.tar.gz',
              'opengrok_dir' => '/opt/opengrok',
            }
          end

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_file('/opt/opengrok-0.13-rc10').with('ensure' => 'directory') }

          it do
            is_expected.to contain_file('/opt/opengrok').with(
              'ensure' => 'link',
              'target' => '/opt/opengrok-0.13-rc10'
            ).that_requires('File[/opt/opengrok-0.13-rc10]')
          end

          it do
            is_expected.to contain_archive('/tmp/opengrok-0.13-rc10.tar.gz').with(
              'ensure'          => 'present',
              'extract'         => 'true',
              'extract_path'    => '/opt/opengrok-0.13-rc10',
              'source'          => 'https://github.com/OpenGrok/OpenGrok/releases/download/0.13-rc10/opengrok-0.13-rc10.tar.gz',
              'extract_command' => 'tar xfz %s --strip-components=1',
              'creates'         => '/opt/opengrok-0.13-rc10/bin',
              'cleanup'         => 'true',
            ).that_requires('File[/opt/opengrok-0.13-rc10]')
          end
        end
      end
    end
  end
end
