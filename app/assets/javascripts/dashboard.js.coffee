# Allows changing of tabs and page refresh while maintaing tabs in 
# dashboard.
# Source: http://stackoverflow.com/questions/9685968/
# best-way-to-make-twitter-bootstrap-tabs-persistent

$(document).ready ->
    if location.hash != ''
        $('a[href="'+location.hash+'"]').tab('show')

    $('a[data-toggle="tab"]').on 'click', (e) ->
        location.hash = $(e.target).attr('href').substr(1)

# Dashboard Friends Auto Completion
# Source: http://railscasts.com/episodes/
# 102-auto-complete-association-revised
jQuery ->
  $('#user_nicknames').autocomplete
    source: $('#user_nicknames').data('autocomplete-source')


