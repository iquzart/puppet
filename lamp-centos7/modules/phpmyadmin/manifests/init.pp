class phpmyadmin {

	#updating YUM repos
	#exec { 'yum-makecache':
	#command => '/usr/bin/yum makecache',
	#}	

	#PHPMYADMIN=======================
	#=================================
	
	#installing repository EPE
	package {'epel-release':
		require => Exec['yum-makecache'],
		ensure => 'present',
	}
	
	#installing package phpmyadmin
	package { 'phpmyadmin':
		require => Package['epel-release'],
		ensure => 'present'
	}
	
	#replacing phpMyAdmin configuration file with our own file
	file { '/etc/httpd/conf.d/phpMyAdmin.conf':
		require => Package['phpmyadmin'],
		ensure => 'file',
		owner => 'root',
		mode => '0744',
	#source => 'puppet:///modules/lamp/phpMyAdmin.conf',
		source  => '/etc/puppet/modules/lamp/files/phpMyAdmin.conf',		
	notify => Service['httpd'],
	}

}

