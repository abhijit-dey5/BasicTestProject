require 'spec_helper'
describe 'pwc_disable_ssl_enable_tls_protocols' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_disable_ssl_enable_tls_protocols') }
  end
end
