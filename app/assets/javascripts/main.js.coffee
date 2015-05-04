$(document).ready ->
  $(window).scroll ->
    distanceFromTop = $(document).scrollTop()
    if distanceFromTop >= $('header').height()
      $('.main-nav').addClass 'fixed'
    else
      $('.main-nav').removeClass 'fixed'
    return
  return