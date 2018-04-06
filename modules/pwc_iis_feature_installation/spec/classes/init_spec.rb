require 'spec_helper'
describe 'pwc_iis_features_install' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_iis_features_install') }
  end
end
