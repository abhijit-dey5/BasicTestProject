# Class: pwc_iis_features_install
# ===========================
#
# Full description of class pwc_iis_features_install here.
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
#    class { 'pwc_iis_features_install':
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
class pwc_iis_features_install(
$ensure_value="",
$installable_features="",
$storage_drive_letter="",
) {

	#required list of IIS roles and features

	#list of web and FTP roles on the IIS server as per PwC standards
	$webftp=[	
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

	#list of FTP rules only as per PwC standards
	$ftponly = [
		"web-ftp-server",
		"web-ftp-service",
		"web-mgmt-console",
		"web-mgmt-service",
		"web-mgmt-tools",
		"web-scripting-tools",
	]

	#list of web rules only as per PwC standards
	$webonly = $webftp-$ftponly

  #required list of directories
  $directories = [
		"$storage_drive_letter:\\IIS_contents",
		"$storage_drive_letter:\\IIS_contents\\IIS_Websites",
		"$storage_drive_letter:\\Ps_Scripts",
		"$storage_drive_letter:\\Ps_Scripts\\IIS",
		"$storage_drive_letter:\\Ps_Scripts\\IIS\\Installation",
		"$storage_drive_letter:\\Back_Up",
		"$storage_drive_letter:\\Back_Up\\IIS",
  ]

	#installing IIS as per required feature list
	if($ensure_value=='present'){
		
		#creating required directories in destination
		file{$directories:
			ensure => directory,
		}

		#setting access to the required directories
		acl{$directories:
			permissions => [
				{ identity => 'Administrators', rights => ['full'] },	
	  		{ identity => 'Users', rights => ['read','write'] }
			],
		}
		
		#installing IIS and it's rules.............

		#installing webonly rules
		if($installable_features == "webonly"){
			iis_feature{$webonly:
				ensure => 'present',
				include_all_subfeatures => true,
				include_management_tools => true,
			}
		}

		#installing ftponly rules
		elsif($installable_features == "ftponly"){
			iis_feature{$ftponly:
				ensure => 'present',
				include_all_subfeatures => true,
				include_management_tools => true,
			}
		}

		#installing webftp rules
		else{
			iis_feature{$webftp:
				ensure => 'present',
				include_all_subfeatures => true,
				include_management_tools => true,
			}
		}

	}

	#uninstalling IIS from the server
	elsif($ensure_value=='absent'){

		#removing all related directories in destination
		file{$directories:
			ensure => 'absent',
			force  => true,
		}

		#uninstalling all IIS rules from the server
		iis_feature{$webftp:
			ensure=>'absent',
		}

	}

} #module ends here
