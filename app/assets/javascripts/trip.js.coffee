# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  init_infinite_scroll()
  init_back_to_top()

  init_onchange_submit($('#searchbox'),$('#occupancy'))
  init_onchange_submit($('#searchbox'),$('#departure'))
  init_onchange_submit($('#searchbox'),$('#return'))


init_infinite_scroll = () ->
  loading = $("<div class='loading'><p>Loading more items&hellip;</p></div>")
  footer = $('#footer')
  opts = {
     offset: '100%'
  };

  footer.waypoint((event, direction) ->
    footer.waypoint('remove')
    $('body').append(loading)
    $.get('/trip.js?page=' + footer.attr('nextpage') + to_param_string(['occupancy','departure','return']), (data) ->
      loading.detach()
      footer.waypoint(opts)
    )
   , opts)

init_back_to_top = () ->
  $('.top').addClass('hidden')

  $('.container').waypoint((event, direction) ->
    $('.top').toggleClass('hidden', direction is "up")
  , { offset: '-100%'})

init_onchange_submit = (form, field, callback) ->
  field.change(() ->
    $('#searchbox').submit()
  )

to_param_string = (params) ->
 ("&" + value + "=" + $('#'+value).val() for value in params ).join('')