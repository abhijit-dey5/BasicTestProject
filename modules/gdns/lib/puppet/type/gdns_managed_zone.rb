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

require 'google/dns/property/integer'
require 'google/dns/property/string'
require 'google/dns/property/string_array'
require 'google/dns/property/time'
require 'google/object_store'
require 'puppet'

Puppet::Type.newtype(:gdns_managed_zone) do
  @doc = <<-DOC
    A zone is a subtree of the DNS namespace under one administrative
    responsibility. A ManagedZone is a resource that represents a DNS zone
    hosted by the Cloud DNS service.
  DOC

  autorequire(:gauth_credential) do
    credential = self[:credential]
    raise "#{ref}: required property 'credential' is missing" if credential.nil?
    [credential]
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
    desc 'The name of the ManagedZone.'
  end

  newproperty(:description, parent: Google::Dns::Property::String) do
    desc <<-DOC
      A mutable string of at most 1024 characters associated with this resource
      for the user's convenience. Has no effect on the managed zone's function.
    DOC
  end

  newproperty(:dns_name, parent: Google::Dns::Property::String) do
    desc 'The DNS name of this managed zone, for instance "example.com.".'
  end

  newproperty(:id, parent: Google::Dns::Property::Integer) do
    desc <<-DOC
      Unique identifier for the resource; defined by the server. (output only)
    DOC
  end

  newproperty(:name, parent: Google::Dns::Property::String) do
    desc <<-DOC
      User assigned name for this resource. Must be unique within the project.
    DOC
  end

  newproperty(:name_servers, parent: Google::Dns::Property::StringArray) do
    desc <<-DOC
      Delegate your managed_zone to these virtual name servers; defined by the
      server (output only)
    DOC
  end

  newproperty(:name_server_set, parent: Google::Dns::Property::StringArray) do
    desc <<-DOC
      Optionally specifies the NameServerSet for this ManagedZone. A
      NameServerSet is a set of DNS name servers that all host the same
      ManagedZones. Most users will leave this field unset.
    DOC
  end

  newproperty(:creation_time, parent: Google::Dns::Property::Time) do
    desc <<-DOC
      The time that this resource was created on the server. This is in RFC3339
      text format. (output only)
    DOC
  end

  # Returns all properties that a provider can export to other resources
  def exports
    provider.exports
  end
end
