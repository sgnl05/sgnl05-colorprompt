require 'spec_helper'
describe 'colorprompt' do
  context 'with default values for all parameters' do
    it { should contain_class('colorprompt') }
  end
end
