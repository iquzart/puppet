class mariadb {
	
	#updating YUM repos
#	exec { 'yum-makecache':
#	command => '/usr/bin/yum makecache',
#	}
 
	#EXPECT ===============
	#=======================
	
	#installing EXPECT package, required to automate MariaDB mysql_secure_installation script
	package { 'expect':
		require => Exec['yum-makecache'],
		ensure => 'present',
	}
	
	#MARIA-SQL ============
	#======================
	
	#installing MariaDB package, require to update YUM repos first
	package { 'mariadb':
		require => Exec['yum-makecache'],
		ensure => 'present',
	}

	#installing MariaDB-server package, require MariaDB package first
	package { 'mariadb-server':
		require => Package['mariadb'],
		ensure => 'present',
	}
	
	#starting MySQL service, require MariaDB and MariaDB-server packages
	service { 'mariadb':
		require => Package['mariadb-server'],
		ensure => 'running',
		enable => 'true',
	}
	
	#Creating file to run mysql_secure_installation script
	file { '/tmp/mysql_secure_installation.sh':
		require => Package['mariadb-server'],
		ensure => 'file',
		owner => 'root',
		mode => '0700',
	#source => 'puppet:///modules/lamp/mysql_secure_installation.sh',
	source  => '/etc/puppet/modules/lamp/files/mysql_secure_installation.sh',
	}
	
	#Running script mysql_secure_installation script.sh
	exec { 'mysql_secure_installation':
		require => File['/tmp/mysql_secure_installation.sh'],
		command => '/tmp/mysql_secure_installation.sh',
		user => 'root',
	}
}	
