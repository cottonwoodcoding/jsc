$ ->
  $(".ac_content").livequery ->
    $ac_background = $("#ac_background")
    $ac_loading = $ac_background.find(".ac_loading")
    $ac_content = $("#ac_content")
    $title = $ac_content.find("h1")
    $menu = $ac_content.find(".ac_menu")
    $mainNav = $menu.find("ul:first")
    $menuItems = $mainNav.children("li")
    totalItems = $menuItems.length

    $('.ac_left').bind 'click', (e) ->
      e.preventDefault()

    #
    #				for this menu, we will preload all the images.
    #				let's add all the image sources to an array,
    #				including the bg image
    #
    Menu = (->
      init = ->
        loadPage()
        initWindowEvent()

      loadPage = ->

        #
        #							1- loads the bg image and all the item images;
        #							2- shows the bg image;
        #							3- shows / slides out the menu;
        #							4- shows the menu items;
        #							5- initializes the menu items events
        #
        $ac_loading.show() #show loading status image
        $.when(slideOutMenu()).done ->
          #hide the loading status image
          $ac_loading.hide()
          $.when(toggleMenuItems("up")).done ->
            initEventsSubMenu()


      slideOutMenu = ->

        # calculate new width for the menu
        new_w = $(window).width() - $title.outerWidth(true)

        #slides out the menu
        $.Deferred((dfd) ->
          $menu.stop().animate
            width: new_w + "px"
          , 400, dfd.resolve
        ).promise()


      # shows / hides the menu items
      toggleMenuItems = (dir) ->

        #
        #							slides in / out the items.
        #							different animation time for each one.
        #
        $.Deferred((dfd) ->
          $menuItems.each (i) ->
            $el_title = $(this).children("a:first")
            marginTop = undefined
            opacity = undefined
            easing = undefined
            if dir is "up"
              marginTop = "0px"
              opacity = 1
              easing = "easeOutBack"
            else if dir is "down"
              marginTop = "60px"
              opacity = 0
              easing = "easeInBack"
            $el_title.stop().animate
              marginTop: marginTop
              opacity: opacity
            , 200 + i * 200, easing, ->
              dfd.resolve()  if i is totalItems - 1
        ).promise()

      initEventsSubMenu = ->
        $menuItems.each ->
          $item = $(this) # the <li>
          $el_title = $item.children("a:first")
          el_image = $el_title.attr("href")
          $sub_menu = $item.find(".ac_subitem")
          $ac_close = $sub_menu.find(".ac_close")

          # user clicks one item
          $el_title.bind "click.Menu", (e) ->
            $.when(toggleMenuItems("down")).done ->
              openSubMenu $item, $sub_menu, el_image
              $('body').keyup (e) ->
                closeSubMenu $sub_menu if (e.keyCode == 27)
            false

          # closes the submenu
          $ac_close.bind "click.Menu", (e) ->
            closeSubMenu $sub_menu
            false

      openSubMenu = ($item, $sub_menu) ->
        $sub_menu.stop().animate
          height: "400px"
          marginTop: "-200px"
        , 400, ->

      closeSubMenu = ($sub_menu) ->
        $sub_menu.stop().animate
          height: "0px"
          marginTop: "0px"
        , 400, ->

          #show items
          toggleMenuItems "up"
      #
      #						on window resize, ajust the bg image dimentions,
      #						and recalculate the menus width
      #
      initWindowEvent = ->

        # on window resize set the width for the menu
        $(window).bind "resize.Menu", (e) ->
          # calculate new width for the menu
          new_w = $(window).width() - $title.outerWidth(true)
          $menu.css "width", new_w + "px"

      init: init)()

    #
    #			call the init method of Menu
    #
    Menu.init()