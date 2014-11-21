require 'spec_helper'

describe 'miomiep' do
  it 'can be configured with a custom middle c' do
    MioMiep.configure do |config|
      config.middle_c = 69
    end
  end
end