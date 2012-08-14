jQuery.fn.selectText = function(){
    var doc = document;
    var element = this[0];
    console.log(this, element);
    if (doc.body.createTextRange) {
        var range = document.body.createTextRange();
        range.moveToElementText(element);
        range.select();
    } else if (window.getSelection) {
        var selection = window.getSelection();
        var range = document.createRange();
        range.selectNodeContents(element);
        selection.removeAllRanges();
        selection.addRange(range);
    }
};

$(function() {
  $('div.entity span').click(function(){
    $(this).selectText();
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
