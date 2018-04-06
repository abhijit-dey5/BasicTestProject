# Class: pwc_iis_update_website
# ===========================
#
# Full description of class pwc_iis_update_website here.
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
#    class { 'pwc_iis_update_website':
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
class pwc_iis_update_website(

$update="",
$site_title="",
$storage_drive="",
$source_path="",

){

$timestamp_modified= generate('/bin/date', '+%m_%d_%Y')
$newtime_modified = $timestamp_modified.chomp
$site_new_path = "$storage_drive:\\IIS_contents\\IIS_website\\$site_title\\$site_title $newtime_modified"
$backup_new_path = "$storage_drive:\\BackUp\\IIS_website\\$site_title\\$site_title $newtime_modified"
$new_dir=["$storage_drive:\\PS_Scripts\\IIS\\Website\\Scripts_for_modification",
	"$storage_drive:\\BackUp\\IIS_website\\$site_title\\$site_title $newtime_modified",
	"$storage_drive:\\IIS_contents\\IIS_website\\$site_title\\$site_title $newtime_modified",
	]

file{$new_dir:
ensure=> directory,
before => File["update_website.ps1"],
}

##setting up permissions for the files and directories that we've used in this code

acl {$new_dir:
 permissions => [
  { identity => 'Administrators', rights => ['full'] },
  { identity => 'Users', rights => ['read','execute'] },
  { identity => 'IUSR', rights => ['full'] },
  { identity => 'IIS_IUSRS', rights => ['full'] },
],
}

file{"update_website.ps1":
ensure  => file,
path    => "$storage_drive:\\PS_Scripts\\IIS\\Website\\Scripts_for_modification\\update_website.ps1",
content => template("$name/updates.ps1.erb"),
notify  =>Exec["update_website"],
}

exec{'update_website':
command   => "$storage_drive:/PS_Scripts/IIS/Website/Scripts_for_modification/update_website.ps1",
path      => "$storage_drive:/PS_Scripts/IIS/Website/Scripts_for_modification",
provider  => 'powershell',
require   => File["update_website.ps1"],
logoutput => true,
}

}
