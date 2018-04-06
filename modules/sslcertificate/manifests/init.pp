# Author::    Paul Stack (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT
# == Define: sslcertificate
#
# This defined type will install SSL Certs on windows
#
# === Requirements/Dependencies
#
# Currently reequires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*password*]
# The password for the given certifcate
#
# [*location*]
# The location to store intermediate certificates.
# Do not end the string with any forward or backslash.
#
# [*thumbprint*]
# The thumbprint used to verify the certifcate
#
# [*store_dir*]
# The certifcate store where the certifcate will be installed to
#
# [*root_store*]
# The store location for the given certifcation store. Either LocalMachine or CurrentUser
#
# [*scripts_dir*]
# The directory where the scripts to verify and install the certificates will be stored.
# By default is C:\temp
#
# [*is_exportable*]
# Flag to set the key as exportable. true == exportable; false == not exportable.
# By default is set to true.
# === Examples
#
# To install a certificate in the My directory of the LocalMachine root store:
#
#  sslcertificate { "Install-PFX-Certificate" :
#    name       => 'mycert.pfx',
#    password   => 'password123',
#    location   => 'C:',
#    thumbprint => '07E5C1AF7F5223CB975CC29B5455642F5570798B'
#  }
#
# To install a certifcate in an alternative directory:
#
#  sslcertificate { "Install-Intermediate-Certificate" :
#    name       => 'go_daddy_intermediate.p7b',
#    location   => 'C:',
#    store_dir  => 'CA',
#    root_store => 'LocalMachine',
#    thumbprint => '07E5C1AF7F5223CB975CC29B5455642F5570798B'
#  }
#
# To install a certificate in the My directory of the LocalMachine root store
# using a different directory to store the scripts:
#
#  sslcertificate { "Install-PFX-Certificate" :
#    name         => 'mycert.pfx',
#    password     => 'password123',
#    location     => 'C:',
#    thumbprint   => '07E5C1AF7F5223CB975CC29B5455642F5570798B',
#    scripts_dir  => 'C:\scripts_dir'
#  }
#
# To install a certificate in the My directory of the LocalMachine root store
# and set the key as not exportable:
#
#  sslcertificate { "Install-PFX-Certificate" :
#    name           => 'mycert.pfx',
#    password       => 'password123',
#    location       => 'C:',
#    thumbprint     => '07E5C1AF7F5223CB975CC29B5455642F5570798B',
#    exportable  => false
#  }
#
class sslcertificate(
#$source_dir = '',


  String[1] $password = '',
  String[1] $location = '',
 # String[1] $thumbprint = '',
  String[1] $store_dir             = "My",
  $storage_drive = "D",
  $cert_name= '',

){


$ps_scripts_dir="$storage_drive:/PS_Scripts/SSLCertificate"

$backup_dir = "$storage_drive:/BackUp/SSL"

#$destination_dir=$store_dir


file{"copy_ssl_content.ps1":
ensure => present,
path =>"$ps_scripts_dir/copy_ssl_content.ps1",
content => template("$name/copy-ssl-content.ps1.erb"),
mode => "0766",
notify => Exec["copy_ssl_content"],
}

exec{"copy_ssl_content":
command => "$ps_scripts_dir/copy_ssl_content.ps1",
provider => "powershell",
logoutput => true,
require => File["copy_ssl_content.ps1"],
#before => Exec["unzip"],
}






  
  #Stdlib::Windowspath $ps_scripts_dir = "C:/temp"
  #$ps_scripts_dir = "C:/Abhijit/Temp/Test_scripts"
  #Boolean $exportable              = true
  $exportable              = true
  #String[1] $root_store            = LocalMachine
  $root_store = "LocalMachine"
  
    
  ensure_resource('file', $ps_scripts_dir, {
    ensure => directory
  })

  if $exportable {
    $key_storage_flags = 'Exportable,PersistKeySet'
  } else {
    $key_storage_flags = 'PersistKeySet'
  }

  file { "inspect-${name}-certificate.ps1":
    ensure  => present,
    path    => "${ps_scripts_dir}/inspect-${name}.ps1",
    content => template('sslcertificate/inspect.ps1.erb'),
    require => File[$ps_scripts_dir],
    #mode    => '0600',
    mode => '0644',
  }

  file { "import-${name}-certificate.ps1":
    ensure  => present,
    path    => "${ps_scripts_dir}/import-${name}.ps1",
    content => template('sslcertificate/import.ps1.erb'),
    require => File[$ps_scripts_dir],
    #mode    => '0600',
    mode => '0644',
  }

  exec { "Install-${name}-SSLCert":
    provider  => 'powershell',
    command   => "${ps_scripts_dir}/import-${name}.ps1",
    onlyif    => "${ps_scripts_dir}/inspect-${name}.ps1",
    logoutput => true,
    require   => [File["inspect-${name}-certificate.ps1"], File["import-${name}-certificate.ps1"]],
    path      => $ps_scripts_dir,
  }


}