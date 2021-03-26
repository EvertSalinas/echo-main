$(function() {
  $("#payment_log_client_id").on("change", function() {
    $("#payment_log_invoice_id select").empty();
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
        $("#payment_log_invoice_id").empty();
        $("#payment_log_invoice_id").append('<option>Seleccionar</option>');
        for(var i=0; i< invoices.length; i++){
          $("#payment_log_invoice_id").append('<option value="' + invoices[i]["id"] + '">' + invoices[i]["system_folio"] + ' - Deuda: ' + invoices[i]["debt"] + '</option>');
        }
      }
    });
  });
});

$($("#payment_log_client_id")).ready(function() {
  if($("#payment_log_client_id")) {
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
        $("#payment_log_invoice_id").empty();
        $("#payment_log_invoice_id").append('<option>Seleccionar</option>');
        for(var i=0; i< invoices.length; i++){
          $("#payment_log_invoice_id").append('<option value="' + invoices[i]["id"] + '">' + invoices[i]["system_folio"] + ' ' + invoices[i]["remaining_balance"] + '</option>');
        }
        return $.ajax({
          url: "/payment_log",
          type: "GET",
          dataType: "json",
          data: {
            folio: $('#payment_log_folio').val()
          },
          error: function (xhr, status, error) {
          },
          success: function (response) {
            $("#payment_log_invoice_id").val(response["payment_log_invoice"]);
          }
        });
      }
    });
  }
});


// debugger;
