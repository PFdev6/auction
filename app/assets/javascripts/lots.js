$(() => {
  $('#lot_files').focus( function() {
    var files = $('#lot_files')[0].files;
    var nameFiles = '';
    for(var i = 0; i< files.length;++i)
    {
      console.log(nameFiles[i])
      nameFiles += files[i].name + ', '
    }
    $('.custom-file-label').text(nameFiles)
  });
});   
