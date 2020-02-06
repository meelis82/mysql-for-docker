class build::mysql::packages {
  package {[
      'lsb-release',
      'gnupg',
      'debconf'
    ]:
    ensure => present
  }
}