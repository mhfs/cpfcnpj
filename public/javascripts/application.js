// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {

  // Showing/Hiding clippy icon on mouse hover
  $('div.entity').hover(function() {
    $(this).children('div.clippy').show();
  },
  function() {
    $(this).children('div.clippy').hide();
  });

  // Cleaning ajax result on submit and input type
  $("#document").keyup(function(){
    $("#validate_response").html("");
  })

  $("#document").click(function(){
    $("#validate_response").html("");
  })

  $("form#validate").submit(function() {
    var document = $('#document').val();
    $.ajax({
      type: "POST",
      url: "/validate",
      data: "document="+ document,
      success: function(data){
        $('#validate_response').html(data);
      }
    });
    return false;
  });

});
