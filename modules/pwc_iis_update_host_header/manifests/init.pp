# Class: pwc_iis_update_host_header
# ===========================
#
# Full description of class pwc_iis_update_host_header here.
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
#    class { 'pwc_iis_update_host_header':
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
class pwc_iis_update_host_header {
$host_ip => '', #The host’s IP address, IPv4 or IPv6.
$host_name => '', #The host name.If omitted defaults to the resource’s title
$host_title => '', #resource name
$host_aliases => [""], #Any aliases the host might have. Multiple values must be specified as an array.
$host_ensure => '', #absent/present
$host_provider => '', #The specific backend to use for this host resource Windows in this case.
$host_target => '', #The file in which to store service information.used by those providers that write to disk defaults to /etc/hosts

host { $host_title :
       name => $host_name,
         ip => $host_ip ,
        host_aliases => $host_aliases ,
        ensure => $host_ensure,
       provider => $host_provider ,
      target=> $host_target,
     }
# augeas{"hostfile" :
 #   context    => "/files/etc/hosts/3/",
  #  changes  => "set ipaddr 8.8.8.8",
  #}
}
