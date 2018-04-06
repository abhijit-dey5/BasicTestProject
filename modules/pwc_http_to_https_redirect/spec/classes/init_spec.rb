require 'spec_helper'
describe 'pwc_http_to_https_redirect' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_http_to_https_redirect') }
  end
end
