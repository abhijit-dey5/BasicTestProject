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

require 'puppet/property'

module Google
  module Compute
    module Data
      # A class to manage data for cache_key_policy for backend_service.
      class BackServCachKeyPoli
        include Comparable

        attr_reader :include_host
        attr_reader :include_protocol
        attr_reader :include_query_string
        attr_reader :query_string_blacklist
        attr_reader :query_string_whitelist

        def to_json(_arg = nil)
          {
            'includeHost' => include_host,
            'includeProtocol' => include_protocol,
            'includeQueryString' => include_query_string,
            'queryStringBlacklist' => query_string_blacklist,
            'queryStringWhitelist' => query_string_whitelist
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            include_host: include_host,
            include_protocol: include_protocol,
            include_query_string: include_query_string,
            query_string_blacklist: query_string_blacklist,
            query_string_whitelist: query_string_whitelist
          }.reject { |_k, v| v.nil? }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? BackServCachKeyPoli
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? BackServCachKeyPoli
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        private

        def compare_fields(other)
          [
            { self: include_host, other: other.include_host },
            { self: include_protocol, other: other.include_protocol },
            { self: include_query_string, other: other.include_query_string },
            {
              self: query_string_blacklist,
              other: other.query_string_blacklist
            },
            {
              self: query_string_whitelist,
              other: other.query_string_whitelist
            }
          ]
        end
      end

      # Manages a BackServCachKeyPoli nested object
      # Data is coming from the GCP API
      class BackServCachKeyPoliApi < BackServCachKeyPoli
        # rubocop:disable Metrics/MethodLength
        def initialize(args)
          @include_host =
            Google::Compute::Property::Boolean.api_munge(args['includeHost'])
          @include_protocol = Google::Compute::Property::Boolean.api_munge(
            args['includeProtocol']
          )
          @include_query_string = Google::Compute::Property::Boolean.api_munge(
            args['includeQueryString']
          )
          @query_string_blacklist =
            Google::Compute::Property::StringArray.api_munge(
              args['queryStringBlacklist']
            )
          @query_string_whitelist =
            Google::Compute::Property::StringArray.api_munge(
              args['queryStringWhitelist']
            )
        end
        # rubocop:enable Metrics/MethodLength
      end

      # Manages a BackServCachKeyPoli nested object
      # Data is coming from the Puppet manifest
      class BackServCachKeyPoliCatalog < BackServCachKeyPoli
        # rubocop:disable Metrics/MethodLength
        def initialize(args)
          @include_host = Google::Compute::Property::Boolean.unsafe_munge(
            args['include_host']
          )
          @include_protocol = Google::Compute::Property::Boolean.unsafe_munge(
            args['include_protocol']
          )
          @include_query_string =
            Google::Compute::Property::Boolean.unsafe_munge(
              args['include_query_string']
            )
          @query_string_blacklist =
            Google::Compute::Property::StringArray.unsafe_munge(
              args['query_string_blacklist']
            )
          @query_string_whitelist =
            Google::Compute::Property::StringArray.unsafe_munge(
              args['query_string_whitelist']
            )
        end
        # rubocop:enable Metrics/MethodLength
      end
    end

    module Property
      # A class to manage input to cache_key_policy for backend_service.
      class BackServCachKeyPoli < Puppet::Property
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::BackServCachKeyPoliCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::BackServCachKeyPoliApi.new(value)
        end
      end
    end
  end
end
