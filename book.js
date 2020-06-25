$(document).ready(function() {

  // Section anchors
  $('.section h1, .section h2, .section h3, .section h4, .section h5, .section h6').each(function() {
    anchor = '#' + $(this).parent().attr('id');
    $(this).addClass("hasAnchor").prepend('<a href="' + anchor + '" class="anchor"></a>');
  });

  // Section anchors
  $('#search-box').each(function() {
    anchor = '#' + $(this).parent().attr('id');
    $(this).append('<button class="close-icon" type="reset"></button>');
  });
});
