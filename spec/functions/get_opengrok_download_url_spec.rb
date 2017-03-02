require 'spec_helper'

describe 'get_opengrok_download_url' do
  it { is_expected.to run.with_params('latest').and_return('https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip') }
  it { is_expected.to run.with_params('0.13-rc10').and_return('https://github.com/OpenGrok/OpenGrok/releases/download/0.13-rc10/opengrok-0.13-rc10.tar.gz') }
end

