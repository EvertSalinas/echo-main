$(function() {
  $("#payment_log_client_id").on("change", function() {
    return $.ajax({
      url: "/invoices",
      type: "GET",
      dataType: "json",
      data: {
        client_id: $('#payment_log_client_id option:selected').val()
      },
      error: function (xhr, status, error) {
      },
      success: function (response) {
        var invoices = response["invoices"];
        $("#payment_log_invoice_id select").empty();
        $("#payment_log_invoice_id select").append('<option>Seleccionar</option>');
        for(var i=0; i< invoices.length; i++){
          $("#payment_log_invoice_id").append('<option value="' + invoices[i]["id"] + '">' + invoices[i]["system_folio"] + '</option>');
        }
      }
    });
  });
});
