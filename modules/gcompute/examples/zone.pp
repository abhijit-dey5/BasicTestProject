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

# Defines a credential to be used when communicating with Google Cloud
# Platform. The title of this credential is then used as the 'credential'
# parameter in the gdns_managed_zone type.
#
# For more information on the gauth_credential parameters and providers please
# refer to its detailed documentation at:
#
#   https://forge.puppet.com/google/gauth
#
# For the sake of this example we set the parameter 'path' to point to the file
# that contains your credential in JSON format. And for convenience this example
# allows a variable named $cred_path to be provided to it. If running from the
# command line you can pass it via Facter:
#
#   FACTER_cred_path=/path/to/my/cred.json \
#       puppet apply examples/zone.pp
#
# For convenience you optionally can add it to your ~/.bash_profile (or the
# respective .profile settings) environment:
#
#   export FACTER_cred_path=/path/to/my/cred.json
#
gauth_credential { 'mycred':
  path     => $cred_path, # e.g. '/home/nelsonjr/my_account.json'
  provider => serviceaccount,
  scopes   => [
    'https://www.googleapis.com/auth/compute',
  ],
}

gcompute_zone { 'us-central1-a':
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}
