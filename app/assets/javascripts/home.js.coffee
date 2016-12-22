document.addEventListener 'turbolinks:load', ->
  $('form').submit ->
    $('#button-submit').hide()
    $('#devise-button-submit').hide()
    $('.sk-cube-grid').show()

  $('.header-alert').delay(4000).fadeOut 'slow'