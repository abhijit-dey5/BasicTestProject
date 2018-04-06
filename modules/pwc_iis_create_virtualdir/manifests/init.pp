# Class: pwc_iis_create_virtualDir
# ===========================
#
# Full description of class pwc_iis_create_virtualDir here.
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
#    class { 'pwc_iis_create_virtualDir':
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
class pwc_iis_create_virtualdir(

$dir_title='', #cannot be blank
$dir_ensure_value="present", #must be either 'present' or 'absent'
$dir_site_name='', #name of the website under which the virtual directory will be created.(not supported in IIS7 and above)
$dir_app_name ='', #name of the application under which the virtual directory will be created.
$source_dir='',
$storage_drive = "D",
$operation_value="deployment"

) {

$timestamp= generate('/bin/date', '+%m %d %Y')
$newtime = $timestamp.chomp

$parent_dir_path = "$storage_drive:\\IIS_contents\\IIS_Virtual_Directories\\$dir_title"
$dir_path="$storage_drive:\\IIS_contents\\IIS_Virtual_Directories\\$dir_title\\$dir_title $newtime"
$parent_backup_dir = "$storage_drive:\\BackUp\\IIS_Virtual_Directories\\$dir_title"
$backup_dir = "$storage_drive:\\BackUp\\IIS_Virtual_Directories\\$dir_title\\$dir_title $newtime"
$ps_script_path = "$storage_drive:\\PS_Scripts\\IIS\\virtual_directories\\$dir_title"

$required_dir_directories=[$parent_dir_path,$parent_backup_dir,$dir_path,$backup_dir,$ps_script_path]

file{$required_dir_directories:
	ensure => 'directory',
}


if($operation_value=="deployment"){

	#taking back up of the source directory content

	file{"copy_directory_content":
		ensure   => file,
		path     =>"$ps_script_path/copy_directory_content.ps1",
		content  => template ("$name/copy-content.ps1.erb"),
		mode     => "0766",
		notify   => Exec["copy_directory_content"],	
	}

	exec{"copy_directory_content":
		command   => "$ps_script_path/copy_directory_content.ps1",
		provider  => "powershell",
		logoutput => true,
		require   => File["copy_directory_content"],
		before    => Exec["unzip_directory_content"],
	}

	#getting contents from the content directory

	file{"unzip_directory_content":
		ensure  => present,
		path    => "$ps_script_path/unzip_directory_content.ps1",
		content => template ("$name/unzip.ps1.erb"),
		mode    => "0766",
		notify  => Exec["unzip_directory_content"],
	}

	exec{"unzip_directory_content":
		command   => "$ps_script_path/unzip_directory_content.ps1",
		provider  => "powershell",
		require   => File["unzip_directory_content"],
		logoutput => true,
	}
}


elsif($operation_value=="rollback"){

	#copying the content of backup directory to the store directory

	file {"rollback_directory_content":
		ensure  => present,
		path    =>"$ps_script_path/rollback_directory_content.ps1",
		content => template ("$name/copy-rollback-content.ps1.erb"),
		mode    => "0766",
		notify  => Exec["rollback_directory_content"],
	}

	exec{"rollback_directory_content":
		command   => "$ps_script_path/rollback_directory_content.ps1",
		provider  => "powershell",
		logoutput => true,
		require   => File["rollback_directory_content"],
		#before   => Exec["unzip_directory_rollback_content"],
	}


}


#creating a new virtual directory

iis_virtual_directory{ $dir_title:
	ensure       => $dir_ensure_value,
	name         => $dir_title ,
	sitename     => $dir_site_name,
	physicalpath => $dir_path,
	application  => $dir_app_name,
}


$directories= [
		$parent_dir_path,
		$dir_path,
		$parent_backup_dir,
		$backup_dir,
		$ps_script_path,
	      ]


acl {$directories:
 permissions => [
  { identity => 'Administrators', rights => ['full'] },
  { identity => 'Users', rights => ['read','execute'] },
  { identity => 'IUSR', rights => ['full'] },
  { identity => 'IIS_IUSRS', rights => ['full'] },
],
}

}
