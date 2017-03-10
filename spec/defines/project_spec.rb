require 'spec_helper'

describe 'opengrok::project',:type => :define do
  let(:title) { 'test-project' }
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "opengrok::project defined type with defaults for all parameters" do
          let (:params) {{}}
            it do
              expect { should compile }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
                              /expects a value for parameter 'source'/)
            end
         end

        context "opengrok::project defined type with good params" do
          let (:params) do
            {
              'ensure' => 'latest',
              'source' => 'https://github.com/jordanconway/puppet-opengrok.git',
              'provider' => 'git',
              'revision' => 'master',
            }
          end
          it { should compile }

          it 'should fail with bad ensure' do
            params['ensure'] = 'purple'
            expect { should compile }.to \
              raise_error(RSpec::Expectations::ExpectationNotMetError,
                /parameter 'ensure' expects a match for Enum\['absent', 'latest', 'present'\]/)
          end
          it 'should fail with bad source' do
            params['source'] = 'I am definitely not a git repo'
            expect { should compile }.to \
              raise_error(RSpec::Expectations::ExpectationNotMetError,
                /parameter 'source' expects a match for Pattern/)
          end
          it 'should fail with bad provider' do
            params['provider'] = 'cvs'
            expect { should compile }.to \
              raise_error(RSpec::Expectations::ExpectationNotMetError,
                /provider' expects a match for Enum\['git'\]/)
          end
          it do
            should contain_vcsrepo('/var/opengrok/src/test-project').with(
              'ensure'   => 'latest',
              'provider' => 'git',
              'source'   => 'https://github.com/jordanconway/puppet-opengrok.git',
              'revision' => 'master',
            )
          end
        end
      end
    end
  end
end
