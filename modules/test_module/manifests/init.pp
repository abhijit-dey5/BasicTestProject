class test_module{
  file{'newfile':
    ensure=>directory,
    path  => 'C:/'
    force =>true,
  }
}