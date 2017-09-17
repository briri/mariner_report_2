$(document).ready(function(){
  
  // Disable any form fields that have the disabled CSS class
  $("input.disabled").prop("disabled", true);
  
  $('.xhrDeactivate').click(function(e){
    if ($(this).attr('data-url')) {
      var url = $(this).attr('data-url');
      var data = '{"active":"false"}';
      
      if ($(this).attr('data-params')) {
        data.replace('}', ','+$(this).attr('data-params')+'}');
      }

      var self = this;
      $.ajax({
        url: url,
        data: data,
        dataType: 'json',
        type: 'DELETE',
        headers: {'Content-Type':'application/json'},

        success: function(json){
          $(self).text(json['msg']).closest('tr').fadeOut('slow');
        },
        error: function(xhr, status, err){
          console.log('Error: '+status+' : '+err);
        }
      });
    }
  });

  $('select.xhrUpdate').blur(function(e){
    if ($(this).attr('data-url')) {
      var url = $(this).attr('data-url');
      var id = $(this).attr('id');
      var data = [];
      $.each($(this).find('option:selected'), function(idx, opt){
        var hash = {};
        hash[id] = $(opt).attr("value");
        data.push(hash);
      });

      if (data) {
        var self = this;
        $.ajax({
          url: url,
          data: JSON.stringify(data),
          dataType: 'json',
          type: 'PUT',
          headers: {'Content-Type':'application/json'},

          success: function(json){
            $(self).text(json['msg']).closest('tr').fadeOut('slow');
          },
          error: function(xhr, status, err){
            console.log('Error: '+status+' : '+err);
          }
        });
      }
    }
  });
});