require 'spec_helper'
describe 'testIISmodule' do
  context 'with default values for all parameters' do
    it { should contain_class('testIISmodule') }
  end
end
