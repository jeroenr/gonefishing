# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  loading = $("<div class='loading'><p>Loading more items&hellip;</p></div>")
  footer = $('#footer')
  opts = {
     offset: '100%'
  };

  ajaxCallback = (data) ->
    loading.detach()
    footer.waypoint(opts)

  infiniteScrollCallback = (event, direction) ->
    footer.waypoint('remove')
    $('body').append(loading)
    $.get('/trip.js?page=' + footer.attr('nextpage'), ajaxCallback)

  footer.waypoint(infiniteScrollCallback, opts)

  $('.top').addClass('hidden')

  backToTopCallback = (event, direction) ->
    $('.top').toggleClass('hidden', direction is "up")
  
  $('.container').waypoint(backToTopCallback, { offset: '-100%'})