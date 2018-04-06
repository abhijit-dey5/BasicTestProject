require 'spec_helper'
describe 'pwc_install_arr' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_install_arr') }
  end
end
