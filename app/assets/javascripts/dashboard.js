// Source: https://github.com/twbs/bootstrap/issues/2415

$(function () {
var activeTab = $('[href=' + location.hash + ']');
activeTab && activeTab.tab('show');
scrollTo(0,0);
});


