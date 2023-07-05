//= require active_admin/base
//= require active_admin/searchable_select
//= require active_admin_sidebar
//= require activeadmin/dynamic_fields

// Functions loaded to ActiveAdmin files need to be here
function set_title(el) {
    product_id = $('#order_order_details_attributes_0_product_id').val()

    $.ajax({
        type: "GET",
        url: `/products/${product_id}`,
        success: function(data) {
            debugger;
            $('#order_order_details_attributes_0_unit_price').empty();
            if(data['price_options'].length > 0) {
                data['price_options'].forEach((price) => {
                    var x = document.getElementById("order_order_details_attributes_0_unit_price");
                    var currency = '$' + price;
                    var option= new Option(currency, price);
                    x.appendChild(option);
                })}},
        error: function(data) {}
    });
}
