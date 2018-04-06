require 'spec_helper'
describe 'pwc_testiis' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_testiis') }
  end
end