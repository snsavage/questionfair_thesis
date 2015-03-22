# // Source: https://github.com/twbs/bootstrap/issues/2415

# $(function () {
# var activeTab = $('[href=' + location.hash + ']');
# activeTab && activeTab.tab('show');
# scrollTo(0,0);
# });

# Source: http://stackoverflow.com/questions/9685968/best-way-to-make-twitter-bootstrap-tabs-persistent
$(document).ready ->
    if location.hash != ''
        $('a[href="'+location.hash+'"]').tab('show')

    $('a[data-toggle="tab"]').on 'shown', (e) ->
        location.hash = $(e.target).attr('href').substr(1)

jQuery ->
  $('#user_nicknames').autocomplete
    source: $('#user_nicknames').data('autocomplete-source')


