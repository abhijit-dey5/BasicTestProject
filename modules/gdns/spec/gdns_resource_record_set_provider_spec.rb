# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by puppet-codegen and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

require 'spec_helper'

describe Puppet::Type.type(:gdns_resource_record_set).provider(:google) do
  before(:all) do
    cred = Google::FakeAuthorization.new
    Puppet::Type.type(:gauth_credential)
                .define_singleton_method(:fetch) { |_resource| cred }
  end

  it '#instances' do
    expect { described_class.instances }.to raise_error(StandardError,
                                                        /not supported/)
  end

  context 'ensure == present' do
    context 'resource exists' do
      # Ensure present: resource exists, no change
      context 'no changes == no action' do
        # Ensure present: resource exists, no change, no name
        context 'title == name' do
          # Ensure present: resource exists, no change, no name, pass
          context 'title == name (pass)' do
            before do
              allow(Time).to receive(:now).and_return(
                Time.new(2017, 1, 2, 3, 4, 5)
              )
              expect_network_get_success 1, name: 'title0',
                                            managed_zone: 'test name#0 data'
              expect_network_get_success 2, name: 'title1',
                                            managed_zone: 'test name#1 data'
              expect_network_get_success 3, name: 'title2',
                                            managed_zone: 'test name#2 data'
              expect_network_get_success_managed_zone 1
              expect_network_get_success_managed_zone 2
              expect_network_get_success_managed_zone 3
            end

            let(:catalog) do
              apply_with_error_check(
                <<-MANIFEST
                gdns_managed_zone { 'resource(managed_zone,0)':
                  ensure     => present,
                  name       => 'test name#0 data',
                  project    => 'test project#0 data',
                  credential => 'cred0',
                }

                gdns_managed_zone { 'resource(managed_zone,1)':
                  ensure     => present,
                  name       => 'test name#1 data',
                  project    => 'test project#1 data',
                  credential => 'cred1',
                }

                gdns_managed_zone { 'resource(managed_zone,2)':
                  ensure     => present,
                  name       => 'test name#2 data',
                  project    => 'test project#2 data',
                  credential => 'cred2',
                }

                gdns_resource_record_set { 'title0':
                  ensure       => present,
                  managed_zone => 'resource(managed_zone,0)',
                  target       => ['ff', 'gg', 'hh'],
                  ttl          => 1842713477,
                  type         => 'A',
                  project      => 'test project#0 data',
                  credential   => 'cred0',
                }

                gdns_resource_record_set { 'title1':
                  ensure       => present,
                  managed_zone => 'resource(managed_zone,1)',
                  target       => ['mm', 'nn', 'oo', 'pp'],
                  ttl          => 3685426954,
                  type         => 'AAAA',
                  project      => 'test project#1 data',
                  credential   => 'cred1',
                }

                gdns_resource_record_set { 'title2':
                  ensure       => present,
                  managed_zone => 'resource(managed_zone,2)',
                  target       => ['tt', 'uu', 'vv', 'ww', 'xx'],
                  ttl          => 5528140432,
                  type         => 'CAA',
                  project      => 'test project#2 data',
                  credential   => 'cred2',
                }
                MANIFEST
              ).catalog
            end

            context 'Gdns_resource_record_set[title0]' do
              subject do
                catalog.resource('Gdns_resource_record_set[title0]').provider
              end

              it { is_expected.to have_attributes(name: 'title0') }
              it { is_expected.to have_attributes(type: 'A') }
              it { is_expected.to have_attributes(ttl: 1_842_713_477) }
              it { is_expected.to have_attributes(target: %w[ff gg hh]) }
            end

            context 'Gdns_resource_record_set[title1]' do
              subject do
                catalog.resource('Gdns_resource_record_set[title1]').provider
              end

              it { is_expected.to have_attributes(name: 'title1') }
              it { is_expected.to have_attributes(type: 'AAAA') }
              it { is_expected.to have_attributes(ttl: 3_685_426_954) }
              it { is_expected.to have_attributes(target: %w[mm nn oo pp]) }
            end

            context 'Gdns_resource_record_set[title2]' do
              subject do
                catalog.resource('Gdns_resource_record_set[title2]').provider
              end

              it { is_expected.to have_attributes(name: 'title2') }
              it { is_expected.to have_attributes(type: 'CAA') }
              it { is_expected.to have_attributes(ttl: 5_528_140_432) }
              it { is_expected.to have_attributes(target: %w[tt uu vv ww xx]) }
            end
          end

          # Ensure present: resource exists, no change, no name, fail
          context 'title == name (fail)' do
            # TODO(nelsonjr): Implement new test format.
            subject { -> { raise '[placeholder] This should fail.' } }
            it { is_expected.to raise_error(RuntimeError, /placeholder/) }
          end
        end

        # Ensure present: resource exists, no change, has name
        context 'title != name' do
          # Ensure present: resource exists, no change, has name, pass
          context 'title != name (pass)' do
            before do
              allow(Time).to receive(:now).and_return(
                Time.new(2017, 1, 2, 3, 4, 5)
              )
              expect_network_get_success 1, managed_zone: 'test name#0 data'
              expect_network_get_success 2, managed_zone: 'test name#1 data'
              expect_network_get_success 3, managed_zone: 'test name#2 data'
              expect_network_get_success_managed_zone 1
              expect_network_get_success_managed_zone 2
              expect_network_get_success_managed_zone 3
            end

            let(:catalog) do
              apply_with_error_check(
                <<-MANIFEST
                gdns_managed_zone { 'resource(managed_zone,0)':
                  ensure     => present,
                  name       => 'test name#0 data',
                  project    => 'test project#0 data',
                  credential => 'cred0',
                }

                gdns_managed_zone { 'resource(managed_zone,1)':
                  ensure     => present,
                  name       => 'test name#1 data',
                  project    => 'test project#1 data',
                  credential => 'cred1',
                }

                gdns_managed_zone { 'resource(managed_zone,2)':
                  ensure     => present,
                  name       => 'test name#2 data',
                  project    => 'test project#2 data',
                  credential => 'cred2',
                }

                gdns_resource_record_set { 'title0':
                  ensure       => present,
                  managed_zone => 'resource(managed_zone,0)',
                  name         => 'test name#0 data',
                  target       => ['ff', 'gg', 'hh'],
                  ttl          => 1842713477,
                  type         => 'A',
                  project      => 'test project#0 data',
                  credential   => 'cred0',
                }

                gdns_resource_record_set { 'title1':
                  ensure       => present,
                  managed_zone => 'resource(managed_zone,1)',
                  name         => 'test name#1 data',
                  target       => ['mm', 'nn', 'oo', 'pp'],
                  ttl          => 3685426954,
                  type         => 'AAAA',
                  project      => 'test project#1 data',
                  credential   => 'cred1',
                }

                gdns_resource_record_set { 'title2':
                  ensure       => present,
                  managed_zone => 'resource(managed_zone,2)',
                  name         => 'test name#2 data',
                  target       => ['tt', 'uu', 'vv', 'ww', 'xx'],
                  ttl          => 5528140432,
                  type         => 'CAA',
                  project      => 'test project#2 data',
                  credential   => 'cred2',
                }
                MANIFEST
              ).catalog
            end

            context 'Gdns_resource_record_set[title0]' do
              subject do
                catalog.resource('Gdns_resource_record_set[title0]').provider
              end

              it { is_expected.to have_attributes(name: 'test name#0 data') }
              it { is_expected.to have_attributes(type: 'A') }
              it { is_expected.to have_attributes(ttl: 1_842_713_477) }
              it { is_expected.to have_attributes(target: %w[ff gg hh]) }
            end

            context 'Gdns_resource_record_set[title1]' do
              subject do
                catalog.resource('Gdns_resource_record_set[title1]').provider
              end

              it { is_expected.to have_attributes(name: 'test name#1 data') }
              it { is_expected.to have_attributes(type: 'AAAA') }
              it { is_expected.to have_attributes(ttl: 3_685_426_954) }
              it { is_expected.to have_attributes(target: %w[mm nn oo pp]) }
            end

            context 'Gdns_resource_record_set[title2]' do
              subject do
                catalog.resource('Gdns_resource_record_set[title2]').provider
              end

              it { is_expected.to have_attributes(name: 'test name#2 data') }
              it { is_expected.to have_attributes(type: 'CAA') }
              it { is_expected.to have_attributes(ttl: 5_528_140_432) }
              it { is_expected.to have_attributes(target: %w[tt uu vv ww xx]) }
            end
          end

          # Ensure present: resource exists, no change, has name, fail
          context 'title != name (fail)' do
            # TODO(nelsonjr): Implement new test format.
            subject { -> { raise '[placeholder] This should fail.' } }
            it { is_expected.to raise_error(RuntimeError, /placeholder/) }
          end
        end
      end

      # Ensure present: resource exists, changes
      context 'changes == action' do
        # Ensure present: resource exists, changes, no name
        context 'title == name' do
          # Ensure present: resource exists, changes, no name, pass
          context 'title == name (pass)' do
            # TODO(nelsonjr): Implement new test format.
          end

          # Ensure present: resource exists, changes, no name, fail
          context 'title == name (fail)' do
            # TODO(nelsonjr): Implement new test format.
            subject { -> { raise '[placeholder] This should fail.' } }
            it { is_expected.to raise_error(RuntimeError, /placeholder/) }
          end
        end

        # Ensure present: resource exists, changes, has name
        context 'title != name' do
          # Ensure present: resource exists, changes, has name, pass
          context 'title != name (pass)' do
            # TODO(nelsonjr): Implement new test format.
          end

          # Ensure present: resource exists, changes, has name, fail
          context 'title != name (fail)' do
            # TODO(nelsonjr): Implement new test format.
            subject { -> { raise '[placeholder] This should fail.' } }
            it { is_expected.to raise_error(RuntimeError, /placeholder/) }
          end
        end
      end
    end

    context 'resource missing' do
      # Ensure present: resource missing, ignore, no name
      context 'title == name' do
        # Ensure present: resource missing, ignore, no name, pass
        context 'title == name (pass)' do
          before(:each) do
            allow(Time).to receive(:now).and_return(
              Time.new(2017, 1, 2, 3, 4, 5)
            )
            expect_network_get_failed 1, name: 'title0',
                                         managed_zone: 'test name#0 data'
            expect_network_get_soa 555, 1, managed_zone: 'test name#0 data'
            expect_network_create_change \
              555, 1, true, load_network_result('create~title.yaml'),
              managed_zone: 'test name#0 data'
            expect_network_get_success_managed_zone 1
          end

          subject do
            apply_with_error_check(
              <<-MANIFEST
              gdns_managed_zone { 'resource(managed_zone,0)':
                ensure     => present,
                name       => 'test name#0 data',
                project    => 'test project#0 data',
                credential => 'cred0',
              }

              gdns_resource_record_set { 'title0':
                ensure       => present,
                managed_zone => 'resource(managed_zone,0)',
                target       => ['ff', 'gg', 'hh'],
                ttl          => 1842713477,
                type         => 'A',
                project      => 'test project#0 data',
                credential   => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gdns_resource_record_set[title0]').provider
              .ensure
          end

          it { is_expected.to eq :present }
        end

        # Ensure present: resource missing, ignore, no name, fail
        context 'title == name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end

      # Ensure present: resource missing, ignore, has name
      context 'title != name' do
        # Ensure present: resource missing, ignore, has name, pass
        context 'title != name (pass)' do
          before(:each) do
            allow(Time).to receive(:now).and_return(
              Time.new(2017, 1, 2, 3, 4, 5)
            )
            expect_network_get_failed 1, managed_zone: 'test name#0 data'
            expect_network_get_soa 666, 1, managed_zone: 'test name#0 data'
            expect_network_create_change \
              666, 1, true, load_network_result('create~name.yaml'),
              managed_zone: 'test name#0 data'
            expect_network_get_success_managed_zone 1
          end

          subject do
            apply_with_error_check(
              <<-MANIFEST
              gdns_managed_zone { 'resource(managed_zone,0)':
                ensure     => present,
                name       => 'test name#0 data',
                project    => 'test project#0 data',
                credential => 'cred0',
              }

              gdns_resource_record_set { 'title0':
                ensure       => present,
                managed_zone => 'resource(managed_zone,0)',
                name         => 'test name#0 data',
                target       => ['ff', 'gg', 'hh'],
                ttl          => 1842713477,
                type         => 'A',
                project      => 'test project#0 data',
                credential   => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gdns_resource_record_set[title0]').provider
              .ensure
          end

          it { is_expected.to eq :present }
        end

        # Ensure present: resource missing, ignore, has name, fail
        context 'title != name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end
    end
  end

  context 'ensure == absent' do
    context 'resource missing' do
      # Ensure absent: resource missing, ignore, no name
      context 'title == name' do
        # Ensure absent: resource missing, ignore, no name, pass
        context 'title == name (pass)' do
          before(:each) do
            allow(Time).to receive(:now).and_return(
              Time.new(2017, 1, 2, 3, 4, 5)
            )
            expect_network_get_failed 1, name: 'title0',
                                         managed_zone: 'test name#0 data'
            expect_network_get_success_managed_zone 1
          end

          subject do
            apply_with_error_check(
              <<-MANIFEST
              gdns_managed_zone { 'resource(managed_zone,0)':
                ensure     => present,
                name       => 'test name#0 data',
                project    => 'test project#0 data',
                credential => 'cred0',
              }

              gdns_resource_record_set { 'title0':
                ensure       => absent,
                managed_zone => 'resource(managed_zone,0)',
                type         => 'A',
                project      => 'test project#0 data',
                credential   => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gdns_resource_record_set[title0]')
              .provider.ensure
          end

          it { is_expected.to eq :absent }
        end

        # Ensure absent: resource missing, ignore, no name, fail
        context 'title == name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end

      # Ensure absent: resource missing, ignore, has name
      context 'title != name' do
        # Ensure absent: resource missing, ignore, has name, pass
        context 'title != name (pass)' do
          before(:each) do
            allow(Time).to receive(:now).and_return(
              Time.new(2017, 1, 2, 3, 4, 5)
            )
            expect_network_get_failed 1, managed_zone: 'test name#0 data'
            expect_network_get_success_managed_zone 1
          end

          subject do
            apply_with_error_check(
              <<-MANIFEST
              gdns_managed_zone { 'resource(managed_zone,0)':
                ensure     => present,
                name       => 'test name#0 data',
                project    => 'test project#0 data',
                credential => 'cred0',
              }

              gdns_resource_record_set { 'title0':
                ensure       => absent,
                managed_zone => 'resource(managed_zone,0)',
                name         => 'test name#0 data',
                type         => 'A',
                project      => 'test project#0 data',
                credential   => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gdns_resource_record_set[title0]')
              .provider.ensure
          end

          it { is_expected.to eq :absent }
        end

        # Ensure absent: resource missing, ignore, has name, fail
        context 'title != name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end
    end

    context 'resource exists' do
      # Ensure absent: resource exists, ignore, no name
      context 'title == name' do
        # Ensure absent: resource exists, ignore, no name, pass
        context 'title == name (pass)' do
          before(:each) do
            allow(Time).to receive(:now).and_return(
              Time.new(2017, 1, 2, 3, 4, 5)
            )
            expect_network_get_success 1, name: 'title0',
                                          managed_zone: 'test name#0 data'
            expect_network_get_soa 111, 1, managed_zone: 'test name#0 data'
            expect_network_create_change \
              111, 1, true, load_network_result('delete~title.yaml'),
              managed_zone: 'test name#0 data'
            expect_network_get_success_managed_zone 1
          end

          subject do
            apply_with_error_check(
              <<-MANIFEST
              gdns_managed_zone { 'resource(managed_zone,0)':
                ensure     => present,
                name       => 'test name#0 data',
                project    => 'test project#0 data',
                credential => 'cred0',
              }

              gdns_resource_record_set { 'title0':
                ensure       => absent,
                managed_zone => 'resource(managed_zone,0)',
                type         => 'A',
                project      => 'test project#0 data',
                credential   => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gdns_resource_record_set[title0]')
              .provider.ensure
          end

          it { is_expected.to eq :absent }
        end

        # Ensure absent: resource exists, ignore, no name, fail
        context 'title == name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end

      # Ensure absent: resource exists, ignore, has name
      context 'title != name' do
        # Ensure absent: resource exists, ignore, has name, pass
        context 'title != name (pass)' do
          before(:each) do
            allow(Time).to receive(:now).and_return(
              Time.new(2017, 1, 2, 3, 4, 5)
            )
            expect_network_get_success 1, managed_zone: 'test name#0 data'
            expect_network_get_soa 222, 1, managed_zone: 'test name#0 data'
            expect_network_create_change \
              222, 1, true, load_network_result('delete~name.yaml'),
              managed_zone: 'test name#0 data'
            expect_network_get_success_managed_zone 1
          end

          subject do
            apply_with_error_check(
              <<-MANIFEST
              gdns_managed_zone { 'resource(managed_zone,0)':
                ensure     => present,
                name       => 'test name#0 data',
                project    => 'test project#0 data',
                credential => 'cred0',
              }

              gdns_resource_record_set { 'title0':
                ensure       => absent,
                managed_zone => 'resource(managed_zone,0)',
                name         => 'test name#0 data',
                type         => 'A',
                project      => 'test project#0 data',
                credential   => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gdns_resource_record_set[title0]')
              .provider.ensure
          end

          it { is_expected.to eq :absent }
        end

        # Ensure absent: resource exists, ignore, has name, fail
        context 'title != name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end
    end
  end

  context '#flush' do
    subject do
      Puppet::Type.type(:gdns_resource_record_set).new(
        ensure: :present,
        name: 'my-name'
      ).provider
    end
    context 'no-op' do
      it { subject.flush }
    end
    context 'modified object' do
      before do
        subject.dirty :some_property, 'current', 'newvalue'
      end
      context 'no-op if created' do
        before { subject.instance_variable_set(:@created, true) }
        it { expect { subject.flush }.not_to raise_error }
      end
      context 'no-op if deleted' do
        before { subject.instance_variable_set(:@deleted, true) }
        it { expect { subject.flush }.not_to raise_error }
      end
    end
  end

  private

  def expect_network_get_success(id, data = {})
    id_data = data.fetch(:name, '').include?('title') ? 'title' : 'name'
    body = load_network_result("success#{id}~#{id_data}.yaml").to_json

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    debug_network "!! GET #{self_link(uri_data(id).merge(data))}"
    expect(Google::Dns::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization)) do |args|
      debug_network ">> GET #{args}"
      request
    end
  end

  def http_success(body)
    response = Net::HTTPOK.new(1.0, 200, 'OK')
    response.body = body
    response.instance_variable_set(:@read, true)
    response
  end

  def expect_network_get_failed(id, data = {})
    request = double('request')
    allow(request).to receive(:send).and_return(http_failed_object_missing)

    debug_network "!! #{self_link(uri_data(id).merge(data))}"
    expect(Google::Dns::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization)) do |args|
      debug_network ">> GET [failed] #{args}"
      request
    end
  end

  def http_failed_object_missing
    Net::HTTPNotFound.new(1.0, 404, 'Not Found')
  end

  def load_network_result(file)
    results = File.join(File.dirname(__FILE__), 'data', 'network',
                        'gdns_resource_record_set', file)
    debug("Loading result file: #{results}")
    raise "Network result data file #{results}" unless File.exist?(results)
    data = YAML.safe_load(File.read(results))
    raise "Invalid network results #{results}" unless data.class <= Hash
    data
  end

  def expect_network_get_success_managed_zone(id, data = {})
    id_data = data.fetch(:name, '').include?('title') ? 'title' : 'name'
    body = load_network_result_managed_zone("success#{id}~" \
                                                           "#{id_data}.yaml")
           .to_json
    uri = uri_data_managed_zone(id).merge(data)

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    debug_network "!! GET #{uri}"
    expect(Google::Dns::Network::Get).to receive(:new)
      .with(self_link_managed_zone(uri),
            instance_of(Google::FakeAuthorization)) do |args|
      debug_network ">> GET #{args}"
      request
    end
  end

  def load_network_result_managed_zone(file)
    results = File.join(File.dirname(__FILE__), 'data', 'network',
                        'gdns_managed_zone', file)
    raise "Network result data file #{results}" unless File.exist?(results)
    data = YAML.safe_load(File.read(results))
    raise "Invalid network results #{results}" unless data.class <= Hash
    data
  end

  # Creates variable test data to comply with self_link URI parameters
  # Only used for gdns_managed_zone objects
  def uri_data_managed_zone(id)
    {
      project: GoogleTests::Constants::MZ_PROJECT_DATA[(id - 1) \
        % GoogleTests::Constants::MZ_PROJECT_DATA.size],
      name: GoogleTests::Constants::MZ_NAME_DATA[(id - 1) \
        % GoogleTests::Constants::MZ_NAME_DATA.size]
    }
  end

  def self_link_managed_zone(data)
    URI.join(
      'https://www.googleapis.com/dns/v1/',
      expand_variables_managed_zone(
        'projects/{{project}}/managedZones/{{name}}',
        data
      )
    )
  end

  def debug(message)
    puts(message) if ENV['RSPEC_DEBUG']
  end

  def debug_network(message)
    puts("Network #{message}") \
      if ENV['RSPEC_DEBUG'] || ENV['RSPEC_HTTP_VERBOSE']
  end

  def expand_variables_managed_zone(template, data, ext_dat = {})
    Puppet::Type.type(:gdns_managed_zone).provider(:google)
                .expand_variables(template, data, ext_dat)
  end

  def create_type(id)
    Puppet::Type.type(:gdns_resource_record_set).new(
      ensure: :present,
      title: "title#{id - 1}",
      credential: "cred#{id - 1}",
      project: GoogleTests::Constants::RRS_PROJECT_DATA[(id - 1) \
        % GoogleTests::Constants::RRS_PROJECT_DATA.size],
      managed_zone: GoogleTests::Constants::RRS_MANAGED_ZONE_DATA[(id - 1) \
        % GoogleTests::Constants::RRS_MANAGED_ZONE_DATA.size],
      name: GoogleTests::Constants::RRS_NAME_DATA[(id - 1) \
        % GoogleTests::Constants::RRS_NAME_DATA.size],
      type: GoogleTests::Constants::RRS_TYPE_DATA[(id - 1) \
        % GoogleTests::Constants::RRS_TYPE_DATA.size]
    )
  end

  def expand_variables(template, data, extra_data = {})
    Puppet::Type.type(:gdns_resource_record_set).provider(:google)
                .expand_variables(template, data, extra_data)
  end

  def expect_network_get_soa(serial, id, extra = {})
    body = load_network_result("soa#{id}-#{serial}.yaml").to_json
    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))
    extra = extra.merge(name: '.', type: :SOA)
    expect(Google::Dns::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(extra)),
            instance_of(Google::FakeAuthorization))
      .and_return(request)
  end

  def expect_network_create_change(change_id, id, done, expected_body,
                                   extra = {})
    body = {
      kind: 'dns#change',
      id: change_id,
      status: done ? 'done' : 'pending'
    }.to_json

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    expect(Google::Dns::Network::Post).to receive(:new)
      .with(collection(uri_data(id).merge(extra)),
            instance_of(Google::FakeAuthorization),
            'application/json', expected_body.to_json)
      .and_return(request)
  end

  def collection(data, extra = '', extra_data = {})
    URI.join(
      'https://www.googleapis.com/dns/v1/',
      expand_variables(
        [
          'projects/{{project}}/managedZones/{{managed_zone}}/changes',
          extra
        ].join,
        data, extra_data
      )
    )
  end

  def self_link(data)
    URI.join(
      'https://www.googleapis.com/dns/v1/',
      expand_variables(
        [
          'projects/{{project}}/managedZones/{{managed_zone}}/rrsets',
          '?name={{name}}&type={{type}}'
        ].join,
        data
      )
    )
  end

  # Creates variable test data to comply with self_link URI parameters
  def uri_data(id)
    {
      project: GoogleTests::Constants::RRS_PROJECT_DATA[(id - 1) \
        % GoogleTests::Constants::RRS_PROJECT_DATA.size],
      managed_zone: GoogleTests::Constants::RRS_MANAGED_ZONE_DATA[(id - 1) \
        % GoogleTests::Constants::RRS_MANAGED_ZONE_DATA.size],
      name: GoogleTests::Constants::RRS_NAME_DATA[(id - 1) \
        % GoogleTests::Constants::RRS_NAME_DATA.size],
      type: GoogleTests::Constants::RRS_TYPE_DATA[(id - 1) \
        % GoogleTests::Constants::RRS_TYPE_DATA.size]
    }
  end
end
