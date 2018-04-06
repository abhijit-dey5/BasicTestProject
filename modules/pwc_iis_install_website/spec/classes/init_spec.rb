require 'spec_helper'
describe 'install_website' do
  context 'with default values for all parameters' do
    it { should contain_class('install_website') }
  end
end
