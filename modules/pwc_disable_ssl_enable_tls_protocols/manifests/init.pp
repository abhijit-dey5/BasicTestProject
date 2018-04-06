# Class: pwc_disable_ssl_enable_tls_protocols
# ===========================
#
# Full description of class pwc_disable_ssl_enable_tls_protocols here.
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
#    class { 'pwc_disable_ssl_enable_tls_protocols':
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
class pwc_disable_ssl_enable_tls_protocols(

$ssl_version = "",
$tls_version = "",
$storage_dir = "E",

){

#$ps_script_path = "$storage_dir:/IIS85/Commands/"
$store_path = "$storage_dir:/IIS_contents/Hardening_Scripts"


file{$store_path:
ensure => directory,
}

file{"copy-content.ps1":
ensure => file,
path   => "$store_path/copy-content.ps1",
content=> template("$name/copy-content.ps1.erb"),
notify => Exec["copy-content"],
}

exec{"copy-content":
command   => "$store_path/copy-content.ps1",
path      => $store_path,
provider  => 'powershell',
require   => File["copy-content.ps1"],
logoutput => true,
}


file { "disable_ssl_enable_tls":
ensure  => file,
path    => "$store_path/Commands/disable_ssl_enable_tls.ps1",
content => template("pwc_disable_ssl_enable_tls_protocols/disable_ssl_enable_tls.ps1.erb"),
notify  => Exec["ssl_disable_tls_enable"],
}


exec{'ssl_disable_tls_enable':
command => "$store_path/Commands/disable_ssl_enable_tls.ps1",
path => "$store_path/Commands",
provider => 'powershell',
require => File["disable_ssl_enable_tls"],
logoutput => true,
}
}
