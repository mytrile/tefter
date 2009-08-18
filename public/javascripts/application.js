// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $('.validation_error').each(function(index, err){
    var input = $(err).prev('input');
    $(err).css('position', 'absolute');
    $(err).css({ top: input.position().top + input.height() + 6, left: input.position().left })
  });
});
