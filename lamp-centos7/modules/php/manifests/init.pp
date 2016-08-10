class php {
	
	#updating YUM repos
#	exec { 'yum-makecache':
#	command => '/usr/bin/yum makecache',
#	}
	
	#PHP ============
	#======================
	
	#installing PHP package, require to update YUM repos first
	package { 'php':
		require => Exec['yum-makecache'],
		ensure => 'present',
	}
	
	#installing PHP-MYSQL package, require to update YUM repos first
	package { 'php-mysql':
		require => Package['php'],
		ensure => 'present',
	}
	
	#creating directory for PHP-INFO file
	file { '/var/www/html':
		require => Package['php-mysql'],
		ensure => 'directory',
	}
	
	#creating PHP-INFO file on APACHE public directory
	file {'/var/www/html/info.php':
		require => File['/var/www/html'],
		ensure => 'present',
		content => '<?php phpinfo(); ?>',
		notify => Service['httpd'],
	}
}
