require 'spec_helper'

describe 'get_opengrok_fname' do

  it {
    is_expected.to run.with_params('latest').and_return('opengrok-0.12.1.6.tar.gz.zip')
  }
  it {
    is_expected.to run.with_params('0.13-rc10').and_return('opengrok-0.13-rc10.tar.gz')
  }
end

