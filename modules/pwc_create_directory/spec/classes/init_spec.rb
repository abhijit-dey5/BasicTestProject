require 'spec_helper'
describe 'pwc_create_directory' do
  context 'with default values for all parameters' do
    it { should contain_class('pwc_create_directory') }
  end
end
