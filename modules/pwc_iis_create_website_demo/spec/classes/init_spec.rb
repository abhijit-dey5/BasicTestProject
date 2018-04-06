require 'spec_helper'
describe 'testiiswebsite' do
  context 'with default values for all parameters' do
    it { should contain_class('testiiswebsite') }
  end
end
