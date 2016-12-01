jQuery ->
  $('#search').autocomplete
    source: '/home/search'
    messages:
      noResults: ''
      results: ->
