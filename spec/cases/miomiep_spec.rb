require 'spec_helper'

describe 'miomiep' do
  it 'can be configured with a custom middle c' do
    MioMiep.configure do |config|
      config.middle_c = 5 #o5th octave
    end
  end
end