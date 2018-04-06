# Class: pwc_iis_create_website
# ===========================
#
# Full description of class pwc_iis_create_website here.
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
#    class { 'pwc_iis_create_website':
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
class pwc_iis_create_website(

$site_title="", #the name of the website. cannot be blank
$site_ensure_value="present", #available values are 'present','absent','started','stopped' 
$site_app_pool_name="DefaultAppPool", #the app pool name which the website will use
$site_enabled_protocol="", #values may be 'http' or 'https'or 'net.pipe
$http_port_number="80", #port number for http binding of the website
$https_port_number="443", #port number for https binding of the website
$site_ip_address="",
$site_host_name="",
$site_certificate_thumbprint="", 
$site_certificate_store="My",
$site_ssl_flags=0,
$source_dir="",
$operation_value="deployment",
$storage_drive = "D",
$server_ipa = "",

) {




#iis_site{"Default Web Site":
#ensure          => 'stopped',
#bindings        => [
#			    {
#			     'bindinginformation'   => "*:89:",
#			     'protocol'             => "http",
#			    },
#			],
#before => Iis_site[$site_title],
#}

##uppercasing the thumbprint of the used SSL certificate
##(It is needed because in system thumbprints are being stored as uppercased characters)

#$site_certificate_hash = upcase($site_certificate_thumbprint)



$required_site_directories = ["$storage_drive:\\BackUp\\IIS_website\\$site_title", "$storage_drive:\\IIS_contents\\IIS_website\\$site_title", "$storage_drive:\\Logs\\IIS\\Website\\$site_title"]

##checking whether the directories for storing log files, website content and backup directories are available or not.
##If not, create a new one

file{$required_site_directories:

ensure => 'directory',

}





##declaring the path for log files,backup directory,site content store and store for related powershell scripts as parameter values

$site_logpath = "$storage_drive:\\Logs\\IIS\\Website\\$site_title\\logfile.txt"
$backup_dir ="$storage_drive:\\BackUp\\IIS_website\\$site_title"
$site_path = "$storage_drive:\\IIS_contents\\IIS_website\\$site_title"
$ps_script_path= "$storage_drive:\\PS_Scripts\\IIS\\Website"


##checking whether the logfile is available or not.
##If not, then create a new one

file{$site_logpath:

ensure => 'file',

}

##setting up the binding information of the website for two different instances('http' and 'https')

$site_binding_information_http = "$site_ip_address:$http_port_number:$site_host_name" 
$site_binding_information_https = "$site_ip_address:$https_port_number:$site_host_name"


if($operation_value =="deployment"){

	###taking back up of the source directory content

	file{"copy_website_content":

		ensure   => file,
		path     =>"$ps_script_path/copy_website_content.ps1",
		content  => template ("$name/copy-content.ps1.erb"),
		mode     => "0766",
		notify   => Exec["copy_website_content"],	

	} #File["copy_website_content"] ends here

	exec{"copy_website_content":
		command   => "$ps_script_path/copy_website_content.ps1",
		provider  => "powershell",
		logoutput => true,
		require   => File["copy_website_content"],
		before    => Exec["unzip_website_content"],

	} #exec["copy_website_content"] ends here

	###getting contents from the content directory

	file{"unzip_website_content":
		ensure  => file,
		path    => "$ps_script_path/unzip_website_content.ps1",
		content => template ("$name/unzip.ps1.erb"),
		mode    => "0766",
		notify  => Exec["unzip_website_content"],

	} # file["unzip_website_content"] ends here

	exec{"unzip_website_content":
		command   => "$ps_script_path/unzip_website_content.ps1",
		provider  => "powershell",
		require   => File["unzip_website_content"],
		logoutput => true,

	} #exec["unzip_website_content":] ends here

} #if($operation_value =="deployment") ends here


elsif($operation_value=="rollback"){

	###copying the content of backup directory to the store directory

	file {"rollback_website_content":
		ensure  => file,
		path    =>"$ps_script_path/rollback_website_content.ps1",
		content => template ("$name/copy-rollback-content.ps1.erb"),
		mode    => "0766",
		notify  => Exec["rollback_website_content"],
	}

	exec{"rollback_website_content":
		command   => "$ps_script_path/rollback_website_content.ps1",
		provider  => "powershell",
		logoutput => true,
		require   => File["rollback_website_content"],
		#before   => Exec["unzip_website_rollback_content"],
	}


} #elsif($operation_value=="rollback") ends here


###creating a new website


if(!empty($site_ensure_value)){


		$site_certificate_hash = upcase($site_certificate_thumbprint)

		iis_site{$site_title:
			ensure           => $site_ensure_value,
			serviceautostart => false,
			name             => $site_title,
			physicalpath     => $site_path,
			applicationpool  => $site_app_pool_name,
			enabledprotocols => $site_enabled_protocol,
			bindings         => [
					    {
					     'bindinginformation'   => $site_binding_information_http,
				             #'protocol'             => $site_protocol,
					     'protocol'             => "http",
					    },
					    {
					     'bindinginformation'   => $site_binding_information_https,
               				     'protocol'             => "https",
					     'certificatehash'      => $site_certificate_hash,
	        			     'certificatestorename' => $site_certificate_store,
        				     'sslflags'             => $site_ssl_flags,
					    },
				          ],
			logformat =>"W3C",
			logpath => $site_logpath, ##"$storage_drive:\\temp\\backup\\logfile.w3c",
			logflags =>[
		
     					"Date",
					"Time",
					"ClientIP",
					"UserName",
					"SiteName",
					"ComputerName",
					"ServerIP",
				        "Method",
					"UriStem",
					"UriQuery",
					"HttpStatus",
					"Win32Status",
					"BytesSent",
				        "BytesRecv",
					"TimeTaken",
					"ServerPort",
					"UserAgent",
					"Cookie",
					"Referer",
				        "ProtocolVersion",
					"Host",
					"HttpSubStatus"	
				   ],

			logperiod => "Hourly",
			loglocaltimerollover => true,

		}

		
		exec{"reset_iis":
			command          => "iisreset",
			provider         => 'powershell',
			require          => IIS_SITE[$site_title],
		}



} #if(!empty($site_ensure_value)) ends here


else{

	$site_ensure = "present"

	$site_certificate_hash = upcase($site_certificate_thumbprint)

	iis_site{$site_title:
		ensure           => $site_ensure,
		serviceautostart => false,
		name             => $site_title,
		physicalpath     => $site_path,
		applicationpool  => $site_app_pool_name,
		enabledprotocols => $site_enabled_protocol,
		bindings         => [
					    {
					     'bindinginformation'   => $site_binding_information_http,
				             #'protocol'             => $site_protocol,
					     'protocol'             => "http",
					    },
					    {
					     'bindinginformation'   => $site_binding_information_https,
               				     'protocol'             => "https",
					     'certificatehash'      => $site_certificate_hash,
	        			     'certificatestorename' => $site_certificate_store,
        				     'sslflags'             => $site_ssl_flags,
					    },

			          ],
		logformat =>"W3C",
		logpath => $site_logpath, ##"$storage_drive:\\temp\\backup\\logfile.w3c",
		logflags =>[

   				"Date",
				"Time",
				"ClientIP",
				"UserName",
				"SiteName",
				"ComputerName",
				"ServerIP",
			        "Method",
				"UriStem",
				"UriQuery",
				"HttpStatus",
				"Win32Status",
				"BytesSent",
			        "BytesRecv",
				"TimeTaken",
				"ServerPort",
				"UserAgent",
				"Cookie",
				"Referer",
			        "ProtocolVersion",
				"Host",
				"HttpSubStatus"	
			   ],
		logperiod => "Hourly",
		loglocaltimerollover => true,

	}

	exec{"reset_iis":
		command          => "iisreset",
		provider         => 'powershell',
		require          => IIS_SITE[$site_title],
	}

			
} #else portion ends here


##putting all the files and dirctories that we've used in this code
	
$directories=[
		$backup_dir,
		$site_path,
		"$storage_drive:\\Logs\\IIS\\Website\\$site_title",
		$site_logpath,
		"$ps_script_path\\copy_website_content.ps1",
		"$ps_script_path\\unzip_website_content.ps1",
		
	     ]

##setting up permissions for the files and directories that we've used in this code

acl {$directories:
 permissions => [
  { identity => 'Administrators', rights => ['full'] },
  { identity => 'Users', rights => ['read','execute'] },
  #{ identity => 'IUSR', rights => ['full'] },
  #{ identity => 'IIS_IUSR', rights => ['full'] },
],
}

if(!empty($site_host_name)){
	file_line{"append a line to new text document":
		path => "C:/Windows/System32/drivers/etc/hosts",
		line => "$server_ipa $site_host_name",
		require => Iis_site[$site_title]
	}
}


##stopping the default website

notify{'Stopping the default website': withpath => true}

exec{"stop default website":
command => "Stop-Website -Name 'Default Web Site' ",
provider => powershell,
}



}#module ends here