class pwc_iis_features_install_demo(

$ensure_value="", #ensures whether IIS services will be installed or uninstalled. Valid values are "present" and "absent" respectively 
$storage_drive = "",


){

$features=[
	    "web-mgmt-console",
	    "web-mgmt-service",
            "web-mgmt-tools",
	    "web-scripting-tools",
	    "web-webserver"
		]


if ($ensure_value == "present"){

$directories=[
		"$storage_drive:/PS_Scripts",
		"$storage_drive:/PS_Scripts/IIS",
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
		"$storage_drive:/BackUp/SSL",
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
ensure=> 'directory',
}

acl {$directories:
 permissions => [
  { identity => 'Administrators', rights => ['full'] },
  { identity => 'Users', rights => ['read','write'] }
 ],
}

#installing IIS and it's roles
	iis_feature{$features:
		ensure => $ensure_value,
		include_all_subfeatures => true,
		#restart => true,
		include_management_tools => true, 
	}


exec{"stop default website":
command => "Stop-Website -Name 'Default Web Site' ",
provider => powershell,
}


exec{"change port of default website":
command => "Set-WebBinding -Name 'Default Web Site' -BindingInformation '*:80:' -PropertyName Port -Value 89 ",
provider => powershell,
}


}

elsif($ensure_value == 'absent'){

$directories=[
		"$storage_drive:/PS_Scripts",
		"$storage_drive:/PS_Scripts/IIS",
		"$storage_drive:/PS_Scripts/IIS/Website",
		"$storage_drive:/PS_Scripts/IIS/app_pool",
		"$storage_drive:/PS_Scripts/IIS/application",
		"$storage_drive:/PS_Scripts/SSLCertificate",
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

iis_feature{$features:
	ensure => $ensure_value,
	#restart => true,
}

}



}