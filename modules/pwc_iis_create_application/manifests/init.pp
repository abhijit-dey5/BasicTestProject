# Class: pwc_iis_create_application
# ===========================
#
# Full description of class pwc_iis_create_application here.
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
#    class { 'pwc_iis_create_application':
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
class pwc_iis_create_application(

$app_title='', #cannot be blank
$app_ensure_value='', #must be either 'present' or 'absent'
$app_site_name ='', #the name of the website under which the application will be hosted..
#$app_sslflags=[], #possible values are 'Ssl', 'SslRequireCert', 'SslNegotiateCert', 'Ssl128'. can add multiple values in the array
$app_pool='', #The name of the application pool for the application.
$app_vir_directory="", #The IIS Virtual Directory to convert to an application on create.
$source_dir='',
$operation_value="deployment",
$storage_dir="",

){

##declaring the path to the application contets and application content backup path.
##will be different paths for each application according to their names.

$timestamp= generate('/bin/date', '+%m %d %Y')
$newtime = $timestamp.chomp

$app_parent_dir= "$storage_dir:\\IIS_contents\\IIS_Application\\$app_title"
$app_path="$storage_dir:\\IIS_contents\\IIS_Application\\$app_title\\$app_title $newtime"
$backup_parent_dir="$storage_dir:\\BackUp\\IIS_Application\\$app_title"
$backup_dir="$storage_dir:\\BackUp\\IIS_Application\\$app_title\\$app_title $newtime"
$ps_script_path = "$storage_dir:\\PS_Scripts\\IIS\\application\\$app_title"

##checking whether required directories exist or not. If not, then creating a new one

file{[$app_parent_dir,$backup_parent_dir,$app_path,$backup_dir,$ps_script_path]:
	ensure => 'directory',
	before => Iis_application[$app_title],
}


if($operation_value=="deployment"){

	#taking back up of the source directory content

	file{"copy_application_content":
		ensure   => file,
		path     =>"$ps_script_path/copy_application_content.ps1",
		content  => template ("$name/copy-content.ps1.erb"),
		mode     => "0766",
		notify   => Exec["copy_application_content"],	
	}

	exec{"copy_application_content":
		command   => "$ps_script_path/copy_application_content.ps1",
		provider  => "powershell",
		logoutput => true,
		require   => File["copy_application_content"],
		before    => Exec["unzip_application_content"],
	}

	#getting contents from the content directory

	file{"unzip_application_content":
		ensure  => present,
		path    => "$ps_script_path/unzip_application_content.ps1",
		content => template ("$name/unzip.ps1.erb"),
		mode    => "0766",
		notify  => Exec["unzip_application_content"],
	}

	exec{"unzip_application_content":
		command   => "$ps_script_path/unzip_application_content.ps1",
		provider  => "powershell",
		require   => File["unzip_application_content"],
		logoutput => true,
	}
}


elsif($operation_value=="rollback"){

	#copying the content of backup directory to the store directory

	file {"rollback_application_content":
		ensure  => present,
		path    =>"$ps_script_path/rollback_application_content.ps1",
		content => template ("$name/copy-rollback-content.ps1.erb"),
		mode    => "0766",
		notify  => Exec["rollback_application_content"],
	}

	exec{"rollback_application_content":
		command   => "$ps_script_path/rollback_application_content.ps1",
		provider  => "powershell",
		logoutput => true,
		require   => File["rollback_application_content"],
		#before   => Exec["unzip_application_rollback_content"],
	}


}



#creating a new application



if($app_vir_directory==""){

iis_application { $app_title:
  ensure          => $app_ensure_value,
  applicationpool => $app_pool,
  applicationname => $app_title,
  sitename        => $app_site_name,
  physicalpath    => $app_path,
  #sslflags           => $app_sslflags,
  authenticationinfo =>{
	'basic'     => true,
	'anonymous' => true,
  },
}


}


else{

iis_application { $app_title:
  ensure          => $app_ensure_value,
  applicationpool => $app_pool,
  applicationname => $app_title,
  sitename        => $app_site_name,
  physicalpath    => $app_path,
  #sslflags           => $app_sslflags,
  virtual_directory  => $app_vir_directory,
  authenticationinfo =>{
	'basic'     => true,
	'anonymous' => true,
  },
}

}

##declaring newly created directories and setting up permission for then

$directories=[
		$backup_parent_dir,
		$app_parent_dir,
		$app_path,
		$backup_dir,
		$ps_script_path,
	     ]

acl {$directories:
 permissions => [
  { identity => 'Administrators', rights => ['full'] },
  { identity => 'Users', rights => ['read','write'] },
  #{ identity => 'IUSR', rights => ['full'] },
  #{ identity => 'IIS_IUSR', rights => ['full'] },
],
}


}
