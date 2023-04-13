$(function() {
  $('#zip_code').blur(function() {
    var zipCode = $(this).val();

    $.get({
      url: `https://viacep.com.br/ws/${zipCode}/json`,
      dataType: "jsonp",
      success: function(data) {
        $('#street').val(data.logradouro);
        $('#complement').val(data.complemento);
        $('#neighborhood').val(data.bairro);
        $('#city').val(data.localidade);
        $('#state').val(data.uf);
        $('#country').val('Brasil');

        $('#street').prop('disabled', false);
        $('#number').prop('disabled', false);
        $('#complement').prop('disabled', false);
        $('#neighborhood').prop('disabled', false);
        $('#city').prop('disabled', false);
        $('#state').prop('disabled', false);
        $('#country').prop('disabled', false);
      }
    });
  });
});
