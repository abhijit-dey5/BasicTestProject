require 'spec_helper'
describe 'pwc_iis_create_app_pool' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_iis_create_app_pool') }
  end
end
