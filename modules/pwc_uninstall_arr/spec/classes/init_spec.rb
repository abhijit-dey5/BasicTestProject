require 'spec_helper'
describe 'pwc_uninstall_arr' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_uninstall_arr') }
  end
end
