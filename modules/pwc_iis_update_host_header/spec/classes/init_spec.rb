require 'spec_helper'
describe 'pwc_iis_update_host_header' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_iis_update_host_header') }
  end
end
