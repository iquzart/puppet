class apache {

	#updating YUM repos
	exec { 'yum-makecache':
	command => '/usr/bin/yum makecache',
	     }
	
	#updating YUM repos
	exec { 'yum update':
	command => '/usr/bin/yum update -y',
	     }

	#APACHE==================
	#========================
	
	#installing APACHE package, require to update YUM repos first
	package { 'httpd':
		require => Exec['yum-makecache'],
		ensure => 'present',
		}
	
	#starting APACHE service, require APACHE package first
	service { 'httpd':
		require => Package['httpd'],
		ensure => 'running',
		enable => true,
		}
	     }
