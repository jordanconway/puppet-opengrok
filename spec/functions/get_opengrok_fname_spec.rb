require 'spec_helper'

describe 'get_opengrok_fname' do
  it { is_expected.to run.with_params('https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip').and_return('opengrok-0.12.1.6.tar.gz.zip') }
  it { is_expected.to run.with_params('https://github.com/OpenGrok/OpenGrok/releases/download/0.13-rc10/opengrok-0.13-rc10.tar.gz').and_return('opengrok-0.13-rc10.tar.gz') }
end
