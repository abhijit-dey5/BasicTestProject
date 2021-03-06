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

require 'google/dns/property/enum'
require 'google/dns/property/integer'
require 'google/dns/property/managedzone_name'
require 'google/dns/property/string'
require 'google/dns/property/string_array'
require 'puppet'

Puppet::Type.newtype(:gdns_resource_record_set) do
  @doc = 'A unit of data that will be returned by the DNS servers.'

  autorequire(:gauth_credential) do
    credential = self[:credential]
    raise "#{ref}: required property 'credential' is missing" if credential.nil?
    [credential]
  end

  autorequire(:gdns_managed_zone) do
    reference = self[:managed_zone]
    raise "#{ref} required property 'managed_zone' is missing" if reference.nil?
    reference.autorequires
  end

  ensurable

  newparam :credential do
    desc <<-DESC
      A gauth_credential name to be used to authenticate with Google Cloud
      Platform.
    DESC
  end

  newparam(:project) do
    desc 'A Google Cloud Platform project to manage.'
  end

  newparam(:name, namevar: true) do
    # TODO(nelsona): Make this description to match the key of the object.
    desc 'The name of the ResourceRecordSet.'
  end

  newparam(:managed_zone, parent: Google::Dns::Property::ManagZoneNameRef) do
    desc 'A reference to ManagedZone resource'
  end

  newproperty(:name, parent: Google::Dns::Property::String) do
    desc 'For example, www.example.com.'
  end

  newproperty(:type, parent: Google::Dns::Property::Enum) do
    desc 'One of valid DNS resource types.'
    newvalue(:A)
    newvalue(:AAAA)
    newvalue(:CAA)
    newvalue(:CNAME)
    newvalue(:MX)
    newvalue(:NAPTR)
    newvalue(:NS)
    newvalue(:PTR)
    newvalue(:SOA)
    newvalue(:SPF)
    newvalue(:SRV)
    newvalue(:TXT)
  end

  newproperty(:ttl, parent: Google::Dns::Property::Integer) do
    desc <<-DOC
      Number of seconds that this ResourceRecordSet can be cached by resolvers.
    DOC
  end

  newproperty(:target, parent: Google::Dns::Property::StringArray) do
    desc 'As defined in RFC 1035 (section 5) and RFC 1034 (section 3.6.1)'
  end
end
