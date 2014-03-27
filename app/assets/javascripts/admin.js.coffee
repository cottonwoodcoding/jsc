$ ->
  $('#update_story').livequery ->
    $(@).click ->
      $(@).html('Updating...')
      $(@).attr('disabled', 'disabled')
      $(@).addClass('disabled')
      $.ajax
        type: 'POST'
        url: '/update_story'
        data: {'story': $('#update_story_content textarea').val()}

  $('.go_back').livequery ->
    $(@).click (e) ->
      e.preventDefault()
      window.location = "http://#{window.location.host}"