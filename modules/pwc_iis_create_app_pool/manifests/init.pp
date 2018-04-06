# Class: pwc_iis_create_app_pool
# ===========================
#
# Full description of class pwc_iis_create_app_pool here.
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
#    class { 'pwc_iis_create_app_pool':
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
class pwc_iis_create_app_pool (

$pool_name='', #name of the application pool to be created.
$pool_ensure_value="present", #Must be either 'present' or 'absent'. Present will ensure the application pool is created.
$pool_username='', #Specifies the identity under which the application pool runs when the identity_type is 'SpecificUser'.
$pool_password='', #Specifies the password associated with the user_name property of the aplication pool.
$pool_identity_type= "ApplicationPoolIdentity", #Specifies the account identity under which the application pool runs.Valid options 'ApplicationPoolIdentity', 'LocalService', 'LocalSystem', 'NetworkService', or 'SpecificUser'.
$pool_state= "started", #The state of the application pool. Must be either 'started' or 'stopped'.
$pool_managed_pipeline_mode="Integrated", #Specifies the request-processing mode that is used to process requests for managed content. Valid options 'Integrated' or 'Classic'.
#$store_dir = '',
#$backup_dir = '',
#$source_dir='',

) {

#Initializing the used parameters which will have a default value

$pool_auto_start= true

$pool_clr_config_file=

$pool_enable32_bit_app_on_win64= true

$pool_enable_configuration_override=

$pool_startup_time_limit='10:00:00'

$pool_shutdown_time_limit= '20:00:00'

$pool_start_mode='AlwaysRunning'

$pool_cpu_reset_interval = '10:00:00'

$pool_idle_timeout= '20:00:00'

$pool_idle_timeout_action= 'Terminate'

$pool_logon_type='LogonBatch'

$pool_max_processes= 1000

$pool_pinging_enabled= true

$pool_ping_interval= '05:00:00'

$pool_ping_response_time= '10:00:00'

$pool_managed_runtime_version= 'v4.0'

$pool_log_event_on_recycle= 'Memory'

$pool_restart_memory_limit= 50000

$pool_queue_length= 100

$destination_dir=$store_dir

$ps_script_path = "C:\\PS_Scripts\\IIS\\app_pool"

#taking back up of the source directory content

#file{"copy_app_pool_content":
#ensure => present,
#path =>"$ps_script_path/copy_app_pool_content.ps1",
#content => template ("$name/copy-content.ps1.erb"),
#mode => "0766",
#notify => Exec["copy_app_pool_content"],
#}

#exec{"copy_app_pool_content":
#command => "$ps_script_path/copy_app_pool_content.ps1",
#provider => "powershell",
#logoutput => true,
#require => File["copy_app_pool_content"],
#before => Exec["unzip_app_pool_content"],
#}

#getting contents from the content directory

#file{"unzip_app_pool_content":
#ensure => present,
#path => "$ps_script_path/unzip_app_pool_content.ps1",
#content => template ("$name/unzip.ps1.erb"),
#mode => "0766",
#notify => Exec["unzip_app_pool_content"],
#}

#exec{"unzip_app_pool_content":
#command => "$ps_script_path/unzip_app_pool_content.ps1",
#provider => "powershell",
#require => File["unzip_app_pool_content"],
#logoutput => true,
#}

#creating a new application pool
if ($pool_identity_type == 'SpecificUser'){

	iis_application_pool{ $pool_name:
		name                         => $pool_name,
		ensure                       => $pool_ensure_value,
		user_name                    => $pool_username,
	  	password                     => $pool_password,
		startup_time_limit           => $pool_startup_time_limit,
		shutdown_time_limit          => $pool_shutdown_time_limit ,
		start_mode                   => $pool_start_mode ,
		cpu_reset_interval           => $pool_cpu_reset_interval ,
		idle_timeout                 => $pool_idle_timeout,
		idle_timeout_action          => $pool_idle_timeout_action ,
		logon_type                   => $pool_logon_type,
		max_processes                => $pool_max_processes,
		pinging_enabled              => $pool_pinging_enabled, #true/false
		ping_interval                => $pool_ping_interval,
		ping_response_time           => $pool_ping_response_time , 
		managed_runtime_version      => $pool_managed_runtime_version,
		log_event_on_recycle         => $pool_log_event_on_recycle,
		restart_memory_limit         => $pool_restart_memory_limit ,
		restart_private_memory_limit => $pool_restart_private_memory_limit, 
		identity_type                => $pool_identity_type,
		state                        => $pool_state,
	}
}

else{

	iis_application_pool{ $pool_name:
		name                         => $pool_name,
		ensure                       => $pool_ensure_value,
		startup_time_limit           => $pool_startup_time_limit,
		shutdown_time_limit          => $pool_shutdown_time_limit ,
		start_mode                   => $pool_start_mode ,
		cpu_reset_interval           => $pool_cpu_reset_interval ,
		idle_timeout                 => $pool_idle_timeout,
		idle_timeout_action          => $pool_idle_timeout_action ,
		logon_type                   => $pool_logon_type,
		max_processes                => $pool_max_processes,
		pinging_enabled              => $pool_pinging_enabled, #true/false
		ping_interval                => $pool_ping_interval,
		ping_response_time           => $pool_ping_response_time , 
		managed_runtime_version      => $pool_managed_runtime_version,
		log_event_on_recycle         => $pool_log_event_on_recycle,
		restart_memory_limit         => $pool_restart_memory_limit ,
		restart_private_memory_limit => $pool_restart_private_memory_limit, 
		identity_type                => $pool_identity_type,
		state                        => $pool_state,
	}

}


}
