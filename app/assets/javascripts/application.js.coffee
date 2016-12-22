#= require jquery
#= require jquery.turbolinks
#= require jquery.ui.all
#= require jquery_ujs
#= require bootstrap
#= require material
#= require song.js.coffee.erb
#= require social-share-button
#= require turbolinks
#= require_tree .

document.addEventListener 'turbolinks:load', ->
  componentHandler.upgradeDom()