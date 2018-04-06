# Class: pwc_uninstall_arr
# ===========================
#
# Full description of class pwc_uninstall_arr here.
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
#    class { 'pwc_uninstall_arr':
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
class pwc_uninstall_arr (
$urlrewrite_path = '',
$arr_path = '',
$webdeploy_path = '',
$webplatform_path = '',
$webfarmframework_path = '',
$externalcachemodule_path = '',
)
{

package{ 'IIS URL Rewrite Module 2':
ensure => 'absent',
source => $urlrewrite_path,
install_options => [ { 'INSTALLDIR' => $urlrewrite_path } ],
provider => 'windows',
} 

package{ 'Microsoft External Cache Version 1 for IIS 7':
ensure => 'absent',
source => $externalcachemodule_path,
install_options => [ { 'INSTALLDIR' => $externalcachemodule_path } ],
provider => 'windows',
}

package{ "Microsoft Web Deploy 2.0":
ensure => 'absent',
source => $webdeploy_path,
install_options => [ { 'INSTALLDIR' => $webdeploy_path } ],
provider => 'windows',
} 

package{ "Microsoft Web Platform Installer 3.0":
ensure => 'absent',
source => $webplatform_path,
install_options => [ { 'INSTALLDIR' => $webplatform_path } ],
provider => 'windows',
}

package{ "Microsoft Web Farm Framework Version 2.2":
ensure => 'absent',
source => $webfarmframework_path,
install_options => [ { 'INSTALLDIR' => $webfarmframework_path } ],
provider => 'windows',
}-> 

package{ 'Microsoft Application Request Routing 3.0':
ensure => 'absent',
source => $arr_path,
install_options => [ { 'INSTALLDIR' => $arr_path } ],
provider => 'windows',
}
 

}