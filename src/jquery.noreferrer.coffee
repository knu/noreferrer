`/**
  @license jquery.noreferrer.js, version 0.1.3
  https://github.com/knu/noreferrer

  Copyright (c) 2011 Akinori MUSHA
  Licensed under the 2-clause BSD license.
*/`

###
  Cross-browser support for HTML5's noreferrer link type.

  This version is for use with jQuery.
###

do ->
  # WebKit based browsers do support rel="noreferrer"
  return if $.browser.webkit

  $.event.add window, 'load', ->
    $('a[href][rel~=noreferrer], area[href][rel~=noreferrer]').each ->
      a = this
      href = a.href

      # Opera seems to have no way to stop sending a Referer header.
      if $.browser.opera
        # Use Google's redirector to hide the real referrer URL
        a.href = 'http://www.google.com/url?q=' + encodeURIComponent(href)
        a.title ||= 'Go to ' + href
        return

      # Disable opening a link in a new window with middle click
      middlebutton = false

      kill_href = (ev) ->
        a.href = 'javascript:void(0)'
        return

      restore_href = (ev) ->
        a.href = href
        return

      $(a).bind('mouseout mouseover focus blur', restore_href
      ).mousedown((ev) ->
        if ev.which == 2
          middlebutton = true
        return
      ).blur((ev) ->
        middlebutton = false
        return
      ).mouseup((ev) ->
        return true unless ev.which == 2 && middlebutton
        kill_href()
        middlebutton = false
        setTimeout (->
          alert '''
            Middle clicking on this link is disabled to keep the browser from sending a referrer.
            '''
          restore_href()
          return
        ), 500
        false
      )

      body = "<html><head><meta http-equiv='Refresh' content='0; URL=#{$('<p/>').text(href).html()}' /></head><body></body></html>"

      if $.browser.msie
        $(a).click (ev) ->
          switch target = @target || '_self'
            when '_self', window.name
              win = window
            else
              win = window.open(null, target)
              # This may be an existing window, hence always call clear().
          doc = win.document
          doc.clear()
          doc.write body
          doc.close()
          false
      else
        uri = "data:text/html;charset=utf-8,#{encodeURIComponent(body)}"
        $(a).click (ev) ->
          @href = uri
          true

      return

    return

  return
