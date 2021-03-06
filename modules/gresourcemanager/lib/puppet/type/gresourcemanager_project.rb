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

require 'google/resourcemanager/property/enum'
require 'google/resourcemanager/property/integer'
require 'google/resourcemanager/property/namevalues'
require 'google/resourcemanager/property/project_parent'
require 'google/resourcemanager/property/string'
require 'google/resourcemanager/property/time'
require 'puppet'

Puppet::Type.newtype(:gresourcemanager_project) do
  @doc = <<-DOC
    Represents a GCP Project. A project is a container for ACLs, APIs, App
    Engine Apps, VMs, and other Google Cloud Platform resources.
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
    desc 'The name of the Project.'
  end

  newparam(:id, parent: Google::Resourcemanager::Property::String) do
    desc <<-DOC
      The unique, user-assigned ID of the Project. It must be 6 to 30 lowercase
      letters, digits, or hyphens. It must start with a letter. Trailing
      hyphens are prohibited.
    DOC
  end

  newproperty(:number, parent: Google::Resourcemanager::Property::Integer) do
    desc 'Number uniquely identifying the project. (output only)'
  end

  newproperty(:lifecycle_state,
              parent: Google::Resourcemanager::Property::Enum) do
    desc 'The Project lifecycle state. (output only)'
    newvalue(:LIFECYCLE_STATE_UNSPECIFIED)
    newvalue(:ACTIVE)
    newvalue(:DELETE_REQUESTED)
    newvalue(:DELETE_IN_PROGRESS)
  end

  newproperty(:name, parent: Google::Resourcemanager::Property::String) do
    desc <<-DOC
      The user-assigned display name of the Project. It must be 4 to 30
      characters. Allowed characters are: lowercase and uppercase letters,
      numbers, hyphen, single-quote, double-quote, space, and exclamation
      point.
    DOC
  end

  newproperty(:create_time, parent: Google::Resourcemanager::Property::Time) do
    desc 'Time of creation (output only)'
  end

  newproperty(:labels, parent: Google::Resourcemanager::Property::NameValues) do
    desc <<-DOC
      The labels associated with this Project. Label keys must be between 1 and
      63 characters long and must conform to the following regular expression:
      `[a-z]([-a-z0-9]*[a-z0-9])?`. Label values must be between 0 and 63
      characters long and must conform to the regular expression
      `([a-z]([-a-z0-9]*[a-z0-9])?)?`. No more than 256 labels can be
      associated with a given resource. Clients should store labels in a
      representation such as JSON that does not depend on specific characters
      being disallowed
    DOC
  end

  newproperty(:parent,
              parent: Google::Resourcemanager::Property::ProjectParent) do
    desc 'A parent organization'
  end
end
