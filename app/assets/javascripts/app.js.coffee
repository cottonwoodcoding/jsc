$ ->
  $('#pay_us_button').livequery ->
    $(@).click (e) ->
      e.preventDefault()
      $paymentAmount = $('#payment_amount')
      if $paymentAmount.val() == ''
        alert('Payment amount cannot be empty.')
      else
        loginWindow = window.open('', 'payment');
        $.ajax
          type: 'POST'
          url: '/payment'
          data: {'payment_amount': $('#payment_amount').val()}
          success: (data) ->
            $paymentAmount.val()
            loginWindow.location.href = data
            $paymentAmount.val() == ''
          error: ->
            alert('There was an error directing you to PayPal please try again.')

  $('.album_title').livequery ->
    $(@).click ->
      $albumTitle = $(@)
      $albumHolder = $(@).next('.album_holder')
      $arrowIcon = $($(@).children()[0])
      albumId = $albumTitle.attr('value')
      albumTitleText = $albumTitle.text()
      if $arrowIcon.hasClass('icon-arrow-right')
        $settingsContainer = $('#our_work_settings, .our_work')
        $settingsContainer.mask("Loading Pictures For #{albumTitleText} Please Wait...")
        $albumHolder.empty()
        $albumHolder.append("<div id='#{albumId}' class='carousel slide'><div class='carousel-inner'></div></div>")
        $.ajax
          type: 'get'
          url: "/album_images/#{$albumTitle.attr('value')}"
          success: (data) ->
            $(data).each (index, value) ->
              image_src = "http://#{value.image_link}"
              if index == 0
                $albumHolder.find('.carousel-inner').append("<div class='item active'><img class='carousel-image' src='#{image_src}'><div class='carousel-caption'>#{albumTitleText}</div></div>")
              else
                $albumHolder.find('.carousel-inner').append("<div class='item'><img class='carousel-image' src='#{image_src}'><div class='carousel-caption'>#{albumTitleText}</div></div>")

            $albumHolder.find('.carousel').append("<span class='carousel-control left pointer' href='##{albumId}' data-slide='prev'>&lsaquo;</span>")
            $albumHolder.find('.carousel').append("<span class='carousel-control right pointer' href='##{albumId}' data-slide='next'>&rsaquo;</span>")
            $arrowIcon.removeClass('icon-arrow-right')
            $arrowIcon.addClass('icon-arrow-down')

            $("##{albumId}").carousel('pause')
            $albumHolder.show()
            $settingsContainer.unmask()
          error: ->
            alert('Error getting images for this album please try again.')
            $settingsContainer.unmask()

      else
        $arrowIcon.removeClass('icon-arrow-down')
        $arrowIcon.addClass('icon-arrow-right')
        $albumHolder.hide()

  $('.see_our_work').livequery ->
    $(@).click ->
      $albums = $('#albums')
      $ourWork = $('.our_work')
      $ourWork.mask('Loading Albums and Images...')
      $albums.empty()
      $.ajax
        type: 'GET'
        url: '/albums'
        success: (data) ->
          $(data).each ->
            $albums.append("<div class='pointer album_title' value='#{@.id}'>Album: #{@.title}<i class='icon-arrow-right'></i></div>")
            $albums.append("<div class='album_holder'></div>")
          $ourWork.unmask()
        error: ->
          $ourWork.unmask()
          alert('Error getting albums please press escape and try again.')
