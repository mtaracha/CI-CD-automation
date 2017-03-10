class users {
  file { '/home/miszcz/text.txt':
    source => "puppet:///modules/${module_name}/text.txt",
  }
}
