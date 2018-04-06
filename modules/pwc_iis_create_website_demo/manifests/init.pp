# Class: testiiswebsite
# ===========================
#
# Full description of class testiiswebsite here.
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
#    class { 'testiiswebsite':
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
class pwc_iis_create_website_demo(

$ensure_value= '',
$site_title='',
$site_app_pool = '',
$site_certificate_thumbprint = '',
$site_certificate_store= "My",
$site_ssl_flags= 0,
$enabled_protocol='',
$http_port_number="80",
$https_port_number="443",
$ftp_port_number="21",
$storage_drive = "D",
$server_ipa = "",
$operation_value ="deployment",
$source_dir="",
$site_hostname = "",
$site_default_page = "",
$site_ip_address = "",

) {


$http_binding_information = "$site_ip_address:$http_port_number:$site_hostname"
$https_binding_information = "$site_ip_address:$https_port_number:$site_hostname"
$site_certificate_hash = upcase($site_certificate_thumbprint)

$timestamp= generate('/bin/date', '+%m_%d_%Y')
$newtime = $timestamp.chomp

$parent_site_path = "$storage_drive:\\IIS_contents\\IIS_website\\$site_title"
$site_path = "$storage_drive:\\IIS_contents\\IIS_website\\$site_title\\$site_title $newtime"
$parent_backup_dir = "$storage_drive:\\BackUp\\IIS_website\\$site_title"
$backup_dir ="$storage_drive:\\BackUp\\IIS_website\\$site_title\\$site_title $newtime"
$parent_site_logpath = "$storage_drive:\\Logs\\IIS\\Website\\$site_title"
$site_logpath = "$storage_drive:\\Logs\\IIS\\Website\\$site_title\\logfile.txt"
$ps_script_path= "$storage_drive:\\PS_Scripts\\IIS\\Website\\$site_title"

$required_site_directories = [$parent_backup_dir, $parent_site_path, $site_path,$parent_site_logpath, $backup_dir,$ps_script_path]


file{$required_site_directories:

ensure => 'directory',

}


file{$site_logpath:

ensure => 'file',

}


#CHECKING WHETHER THE DEFAULT WEBSITE IS IN STOPPED STATE OR NOT
#IF NOT, STOP THE DEFAULT WEB SITE

exec{"stop default website":
command => "Stop-Website -Name 'Default Web Site' ",
provider => powershell,
}



if($operation_value =="deployment"){

	###taking back up of the source directory content

	file{"copy_website_content":

		ensure   => file,
		path     =>"$ps_script_path/copy_website_content.ps1",
		content  => template ("$name/copy-content.ps1.erb"),
		mode     => "0755",
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
		mode    => "0755",
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
		mode    => "0755",
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



if($enabled_protocol == "https"){


iis_site{$site_title:
	ensure           => $ensure_value,
	serviceautostart => false,
	name             => $site_title,
	physicalpath     => $site_path,
	applicationpool  => $site_app_pool,
	enabledprotocols => $enabled_protocol,
	bindings         => [
			    {
			     'bindinginformation'   => $http_binding_information,
		             #'protocol'             => $site_protocol,
			     'protocol'             => "http",
			    },
			    {
			     'bindinginformation'   => $https_binding_information,
     			     'protocol'             => "https",
			     'certificatehash'      => $site_certificate_hash,
       			     'certificatestorename' => $site_certificate_store,
     			     'sslflags'             => $site_ssl_flags,
			    },
		          ],

	defaultpage       => $site_default_page,

}

#file{"http to https":
#ensure => file,
#path => "$ps_script_path/http_to_https.ps1",
#content => template("$name/http to https.ps1.erb"),
#notify => Exec["http to https"],
#}

#exec{"http to https":
#command => "$ps_script_path/http_to_https.ps1",
#provider => 'powershell',
#logoutput => true,
#require => File["http to https"],
#}

file_line{"append a line to new text document":
	path => "C:/Windows/System32/drivers/etc/hosts",
	line => "$server_ipa $site_hostname",
	require => Iis_site[$site_title],
}

#file_line{"append a new line to new text document":
#	path => "C:/Windows/System32/drivers/etc/hosts",
#	line => "$server_ipa $https_hostname",
#	require => Iis_site[$site_title],
#}

}

else{

if($enabled_protocol == "ftp"){

file{$site_title:
ensure => file,
path => "$ps_script_path/create-ftp-site.ps1",
content => template("$name/create-ftp-site.ps1.erb"),
notify => Exec[$site_title],

}

exec{$site_title:
	command => "$ps_script_path/create-ftp-site.ps1",
	path => $ps_script_path,
	provider => 'powershell',
}

file_line{"append a line to new text document":
	path => "C:/Windows/System32/drivers/etc/hosts",
	line => "$server_ipa $site_hostname",
	require => Exec[$site_title],
}

}

else{
	iis_site{$site_title:
		ensure           => $ensure_value,
		serviceautostart => false,
		name             => $site_title,
		physicalpath     => $site_path,
		applicationpool  => $site_app_pool,
		enabledprotocols => $enabled_protocol,
		bindings         => [
				    {
				     'bindinginformation'   => $http_binding_information,
			             #'protocol'             => $site_protocol,
				     'protocol'             => "http",
				    },
	
			          ],
	
		defaultpage       => $site_default_page,
	
	}
	
	file_line{"append a line to new text document":
		path => "C:/Windows/System32/drivers/etc/hosts",
		line => "$server_ipa $site_hostname",
		require => Iis_site[$site_title],
	}


}

}



$directories=[
		$backup_dir,
		$site_path,
		"$storage_drive:\\Logs\\IIS\\Website\\$site_title",
		$site_logpath,
		
	     ]

##setting up permissions for the files and directories that we've used in this code

acl {$directories:
 permissions => [
  { identity => 'Administrators', rights => ['full'] },
  { identity => 'Users', rights => ['read','execute'] },
  { identity => 'IUSR', rights => ['full'] },
  { identity => 'IIS_IUSRS', rights => ['full'] },
],
}


}
