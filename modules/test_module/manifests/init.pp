class test_module(
$file_list,
){
  $new_file_path = $file_list['directories']
  file{$new_file_path:
    ensure => directory,
    #path   => $new_file_path,
  }
}
