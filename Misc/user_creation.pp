 user { 'test1':
 	   ensure           => 'present',
       gid              => '503',
       home             => '/home/test1',
       password         => '!!',
       password_max_age => '99999',
       password_min_age => '0',
       shell            => '/bin/bash',
       uid              => '503',
     }