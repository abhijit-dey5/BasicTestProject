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
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

require 'google/authorization'
require 'google/sql/network/get'
require 'json'

# Returns the IP address associated with the SQL instance managed by a
# `gsql_instance` resource.
#
# Arguments:
#   - name: string
#     the name of the SQL instance resource
#   - project: string
#     the project name where resource is allocated
#   - cred: authorization
#     the credential to use to authorize the information request
#
# Examples:
#   - gsql_instance_ip('my-db', 'my-project', $fn_auth)
#
# The credential parameter should be allocated with a
# `gauth_credential_*_for_function` call.
Puppet::Functions.create_function(:gsql_instance_ip) do
  dispatch :gsql_instance_ip do
    param 'String', :name
    param 'String', :project
    param 'Runtime[ruby, "Google::Authorization"]', :cred
  end

  def gsql_instance_ip(name, project, cred)
    get_request = ::Google::Compute::Network::Get.new(
      gsql_instance_self_link(name, project), cred
    )
    response = JSON.parse(get_request.send.body)
    response['ipAddresses'][0]['ipAddress'] if response.key?('ipAddresses')
  end

  def gsql_instance_self_link(name, project)
    URI.join(
      'https://www.googleapis.com/sql/v1beta4/',
      "projects/#{project}/",
      "instances/#{name}"
    )
  end
end
