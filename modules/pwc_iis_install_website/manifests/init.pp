# Class: install_website
# ===========================
#
# Full description of class install_website here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'install_website':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class pwc_iis_install_website{
#package { 'windows': ensure => 'present', provider => 'windows', install_options => ['-pre'], } 
dsc_windowsfeature{'iis':
  dsc_ensure => 'present',
  dsc_name   => 'Web-Server',
}
dsc_windowsfeature{'aspnet45':
  dsc_ensure => 'Present',
  dsc_name   => 'Web-Asp-Net45',
}
dsc_xwebsite{'defaultsite':
  dsc_ensure       => 'Present',
  dsc_name         => 'Default Web Site',
  dsc_state        => 'Stopped',
  dsc_physicalpath => 'c:\\inetpub\\wwwroot',
}
dsc_file{'websitefolder':
  dsc_ensure		=> 'present',
  #dsc_ensure          => 'directory',
  #dsc_sourcepath      => 'e:\\dinesh\\website_code',
  dsc_sourcepath      => 'C:\\New folder',
  dsc_destinationpath => 'C:\\Destination',
  #dsc_destinationpath => 'c:\\inetpub\\foo',
  #dsc_recurse         => true,
  #dsc_type            => 'Directory',
}
dsc_xwebapppool{'newwebapppool':
  dsc_name                      => 'PuppetCodezAppPool',
  dsc_ensure                    => 'Present',
  dsc_managedruntimeversion     => 'v4.0',
  dsc_logeventonrecycle         => 'Memory',
  dsc_restartmemorylimit        => '1000',
  dsc_restartprivatememorylimit => '1000',
  dsc_identitytype              => 'ApplicationPoolIdentity',
  dsc_state                     => 'Started',
}
dsc_xwebsite{'newwebsite':
  dsc_ensure          => 'Present',
  dsc_name            => 'PuppetCodez',
  dsc_state           => 'Started',
  dsc_physicalpath    => 'c:\\inetpub\\foo',
  dsc_applicationpool => 'PuppetCodezAppPool',
  dsc_bindinginfo     => [{
    protocol => 'HTTP',
    port     => 80,
  }]
}
#node default{ }
#node 'ukgbdcmdfdw604.uk.ema.ad.pwcinternal.com' {
#include install_website  
#}
}
