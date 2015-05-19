$(document).ready ->
  $('select#beer_filter').change ->
    $(this).closest('form').submit()
    return
  return