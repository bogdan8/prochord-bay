$(function() {
  var fileInputTextDiv = $('#file_input_text_div');
  var fileInput = $('#file_input_file');
  var fileInputText = $('#file_input_text');

  fileInput.on('change', changeInputText);
  fileInput.on('change', changeState);

  function changeInputText() {
    var str = fileInput[0].value;
    var i;
    if (str.lastIndexOf('\\')) {
      i = str.lastIndexOf('\\') + 1;
    } else if (str.lastIndexOf('/')) {
      i = str.lastIndexOf('/') + 1;
    }
    fileInputText[0].value = str.slice(i, str.length);
  }

  function changeState() {
    if (fileInputText[0].value.length != 0) {
      if (!fileInputTextDiv[0].classList.contains("is-focused")) {
        fileInputTextDiv[0].classList.add('is-focused');
      }
    } else {
      if (fileInputTextDiv[0].classList.contains("is-focused")) {
        fileInputTextDiv[0].classList.remove('is-focused');
      }
    }
  }
});