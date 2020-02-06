class build::mysql {
  require build::mysql::packages
  require build::mysql::mysqlpackage
  require build::mysql::supervisor
  require build::mysql::logs

  file { '/etc/mysql/mysql.conf.d/mysqld.cnf':
    ensure => present,
    source => 'puppet:///modules/build/etc/mysql/mysqld.cnf',
    mode => "644"
  }

  file { '/etc/mysql/conf.d/mysqld_safe_syslog.cnf':
    ensure => absent
  }

  file { '/var/log/mysql/error.log':
    ensure => absent
  }

  file { '/var/log/mysql.log':
    ensure => absent
  }

  file { '/var/log/mysql.err':
    ensure => absent
  }
}
