document.addEventListener "turbolinks:load", ->
  jQuery ->
    $('#search').autocomplete
      source: '/home/search'
      messages:
        noResults: ''
        results: ->
