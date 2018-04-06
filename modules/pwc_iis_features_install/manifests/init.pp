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
# Copyright 2017 Your name here, unless otherwise noted.
#
class pwc_iis_features_install(

$ensure_value="", #ensures whether IIS services will be installed or uninstalled. Valid values are "present" and "absent" respectively 
$installable_features = "webftp", #determines which type of features to be installed. Valid values are 'webftp','webonly' and 'ftponly'
$storage_drive = "",
){


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
	    "web-scripting-tools"
]

#list of web rules only as per PwC standards

$webonly = $webftp-$ftponly

if ($ensure_value == "present"){

$directories=[
		"$storage_drive:/PS_Scripts",
		"$storage_drive:/PS_Scripts/IIS",
		"$storage_drive:/PS_Scripts/IIS/Installation",
		"$storage_drive:/PS_Scripts/IIS/Website",
		"$storage_drive:/PS_Scripts/IIS/app_pool",
		"$storage_drive:/PS_Scripts/IIS/application",
		"$storage_drive:/PS_Scripts/IIS/virtual_directories",
		"$storage_drive:/PS_Scripts/SSLCertificate",
		"$storage_drive:/BackUp",
		"$storage_drive:/BackUp/IIS_App_Pool",
		"$storage_drive:/BackUp/IIS_Application",
		"$storage_drive:/BackUp/IIS_Virtual_Directories",
		"$storage_drive:/BackUp/IIS_website",
		"$storage_drive:/IIS_contents",
		"$storage_drive:/IIS_contents/IIS_App_Pool",
		"$storage_drive:/IIS_contents/IIS_Application",
		"$storage_drive:/IIS_contents/IIS_Virtual_Directories",
		"$storage_drive:/IIS_contents/IIS_website",
		"$storage_drive:\\Logs",
		"$storage_drive:\\Logs\\IIS",
		"$storage_drive:\\Logs\\IIS\\Website",
		"$storage_drive:\\Logs\\IIS\\Website\\Modification_log",
	     ]


$modification_logfiles =[
				"$storage_drive:\\Logs\\IIS\\Website\\Modification_log\\logfile.txt",
"
			]

file{$directories:
ensure=> 'directory',
}

file{$modification_logfiles:
ensure => file,
}

acl {$directories:
 permissions => [
  { identity => 'Administrators', rights => ['full'] },
  { identity => 'Users', rights => ['read','write'] }
 ],
}

#installing IIS and it's roles

if($installable_features == "webftp"){
	iis_feature{$webftp:
		ensure => $ensure_value,
		include_all_subfeatures =>true,
		#restart => true,
		include_management_tools => true,
		notify  => File["customize default website"], 
	}
}

elsif($installable_features == "ftponly"){
	iis_feature{$ftponly:
		ensure => $ensure_value,
		include_all_subfeatures => true,
		#restart => true,
		include_management_tools => true, 
		notify  => File["customize default website"],
	}
}

elsif($installable_features == "webonly"){
	iis_feature{$webonly:
		ensure => $ensure_value,
		include_all_subfeatures => true,
		#restart => true,
		include_management_tools => true, 
		notify  => File["customize default website"],
	}
}



file{"customize default website":
ensure => 'file',
path   => "$storage_drive:/PS_Scripts/IIS/Installation/customize_default_web_site.ps1",
content=> template("$name/customize default web site.ps1.erb"),
notify => Exec["customize default website"],
}
exec{"customize default website":
command => "$storage_drive:/PS_Scripts/IIS/Installation/customize_default_web_site.ps1",
path => "$storage_drive:/PS_Scripts/IIS/Installation",
provider => powershell,
require => File["customize default website"],
}


}

elsif($ensure_value == 'absent'){

$directories=[
		"$storage_drive:/PS_Scripts",
		"$storage_drive:/PS_Scripts/IIS/Installation",
		"$storage_drive:/PS_Scripts/IIS/Website",
		"$storage_drive:/PS_Scripts/IIS/app_pool",
		"$storage_drive:/PS_Scripts/IIS/application",
		"$storage_drive:/PS_Scripts/SSLCertificate",
		"$storage_drive:/PS_Scripts/IIS/virtual_directories",
		"$storage_drive:/IIS_contents",
		"$storage_drive:/IIS_contents/IIS_App_Pool",
		"$storage_drive:/IIS_contents/IIS_Application",
		"$storage_drive:/IIS_contents/IIS_Virtual_Directories",
		"$storage_drive:/IIS_contents/IIS_website",
		"$storage_drive:\\Logs",
		"$storage_drive:\\Logs\\IIS",
		"$storage_drive:\\Logs\\IIS\\Website",
	     ]


file{$directories:
ensure=> 'absent',
force => true,
}


##removing all iis websites and application pool

file{"remove iis components":
ensure => file,
path   => "$storage_drive:/$storage_drive:/PS_Scripts/IIS/remove iis components.ps1",
content=> template("$name/remove iis components.ps1.erb"),
notify => Exec["remove iis components"],
}

exec{"remove iis components":
command => "$storage_drive:/$storage_drive:/PS_Scripts/IIS/remove iis components.ps1",
path    => "$storage_drive:/$storage_drive:/PS_Scripts/IIS",
provider=> 'powershell',
}

#installing IIS and it's roles

if($installable_features == "webftp"){
	iis_feature{$webftp:
		ensure => $ensure_value,
		#restart => true,
	}
}

elsif($installable_features == "ftponly"){
	iis_feature{$ftponly:
		ensure => $ensure_value,
		#restart => true,
	}
}

elsif($installable_features == "webonly"){
	iis_feature{$webonly:
		ensure => $ensure_value,
		#restart => true,
	}
}

}



}
