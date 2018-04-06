require 'spec_helper'
describe 'pwc_testmod' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_testmod') }
  end
end
