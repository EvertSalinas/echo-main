//= require active_admin/base
//= require active_admin/searchable_select
//= require active_admin_sidebar
//= require activeadmin/dynamic_fields

// Functions loaded to ActiveAdmin files need to be here
function set_title(el) {
    // debugger;
    product_id = $('#order_order_details_attributes_0_product_id').val()

    // if($('#article_title').val().trim() === '') {
    //     $('#article_title').val(args[0]);
    //     $('#article_title').trigger('change');
    // }
    $.ajax({
        type: "GET",
        url: `/products/${product_id}`,
        success: function(data) {
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
