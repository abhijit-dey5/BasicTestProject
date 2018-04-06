# Class: pwc_install_arr
# ===========================
#
# This Module Installs Microsoft Application Request Router 3.0 and its prerequisites (e.g: IIS UrlRewrite Module, Microsoft External Cache Version,
# Web Deploy Module, Web Platform Installer and Web Farm Framework)
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
#    class { 'pwc_install_arr':
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
class pwc_install_arr
(
$urlrewrite_path = '',
$arr_path = '',
$webdeploy_path = '',
$webplatform_path = '',
$webfarmframework_path = '',
$externalcachemodule_path = '',
$proxy_enable_value = true,
$storage_dir = "D",

){

$ps_script_path = "$storage_dir:/PS_Scripts/ARR"

file{["$storage_dir:/PS_Scripts","$storage_dir:/PS_Scripts/ARR"]:

ensure => directory,
notify   => File["enable_or_disable_arrproxy"],

}


acl {["$storage_dir:/PS_Scripts","$storage_dir:/PS_Scripts/ARR"]:
	permissions => [
			{ identity => 'Administrators', rights => ['full'] },
			{ identity => 'Users', rights => ['read','execute'] }
	 ],
}



if ($urlrewrite_path != null){

	package{ 'IIS URL Rewrite Module 2':
		ensure => 'installed',
		source => $urlrewrite_path,
		install_options => [ { 'INSTALLDIR' => $urlrewrite_path } ],
		provider => 'windows',
	}

}

if ($externalcachemodule_path != null) {

	package{ 'Microsoft External Cache Version 1 for IIS 7':
		ensure => 'installed',
		source => $externalcachemodule_path,
		install_options => [ { 'INSTALLDIR' => $externalcachemodule_path } ],
		provider => 'windows',
	}

}

if ($webdeploy_path != null) {

	package{ "Microsoft Web Deploy 2.0":
		ensure => 'installed',
		source => $webdeploy_path,
		install_options => [ { 'INSTALLDIR' => $webdeploy_path } ],
		provider => 'windows',
	}
 
}

if ($webplatform_path != null) {

	package{ "Microsoft Web Platform Installer 3.0":
		ensure => 'installed',
		source => $webplatform_path,
		install_options => [ { 'INSTALLDIR' => $webplatform_path } ],
		provider => 'windows',
	}

}

if ($webfarmframework_path != null){

	package{ "Microsoft Web Farm Framework Version 2.2":
		ensure => 'installed',
		source => $webfarmframework_path,
		install_options => [ { 'INSTALLDIR' => $webfarmframework_path } ],
		provider => 'windows',
	}

} 

if ($arr_path != null) {

	package{ 'Microsoft Application Request Routing 3.0':
		ensure => 'installed',
		source => $arr_path,
		install_options => [ { 'INSTALLDIR' => $arr_path } ],
		provider => 'windows',
		notify   => File["enable_or_disable_arrproxy"],
	}

}


#ENABLING OR DISABLING THE PROXY SETTING FOR ARR
 
file { "enable_or_disable_arrproxy":

ensure  => file,
path    => "$ps_script_path/enable_or_disable_arrproxy.ps1",
content => template("$name/enabledisable_proxy.ps1.erb"),

}


exec{'enable_disable_proxy':

command => "$ps_script_path/enable_or_disable_arrproxy.ps1",
path => $ps_script_path,
provider => 'powershell',
require => File["enable_or_disable_arrproxy"],

}


}



