# Class: pwc_testiis
# ===========================
#
# Full description of class pwc_testiis here.
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
#    class { 'pwc_testiis':
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
# Copyright 2018 Your name here, unless otherwise noted.
#
class pwc_testiis(
  $iis_feature="",
  $ensure_value="",

) {
  #list of web rules and ftp rules as per PwC standard
  $webftp = [
    "web-app-dev",
	  "web-appinit",
  	"web-asp",
  	"web-asp-net",
  	"web-asp-net45",
  	"web-common-http",
  	"web-default-doc",
  	"web-dyn-compression",
  	"web-filtering",
  	"web-health",
  	"web-http-errors",
  	"web-http-logging",
  	"web-http-redirect",
  	"web-http-tracing",
  	"web-isapi-ext",
  	"web-isapi-filter",
  	"web-log-libraries",
  	"web-mgmt-console",
  	"web-mgmt-service",
  	"web-mgmt-tools",
  	"web-net-ext",
  	"web-net-ext45",  
    "web-performance",
  	"web-request-monitor",
  	"web-security",
  	"web-scripting-tools",
  	"web-server",
  	"web-stat-compression",
  	"web-static-content",
  	"Web-WebServer",
  	"web-websockets",
  	"web-windows-auth",
	  "web-ftp-server",
  	"web-ftp-service"
  ]


  #List of ftp features as per PwC standard
  $ftponly=[
     "web-ftp-server",
     "web-ftp-service",
     "web-mgmt-console",
     "web-mgmt-service",
     "web-mgmt-tools",
     "web-scripting-tools"
  ]

  #List of web features as per PwC standard
  $webonly = $webftp-$ftponly
  
  
  if($iis_feature == "webonly"){
    iis_feature{$webftp:
      ensure => $ensure_value,
    }
  }

  elsif($iis_feature == "ftponly"){
    iis_feature{ $ftponly:
      ensure => $ensure_value,
    }
  }

  else{
    iis_feature{ $webftp:
      ensure => $ensure_value
    }
  }

}
#new comment line
