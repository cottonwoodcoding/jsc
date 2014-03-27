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