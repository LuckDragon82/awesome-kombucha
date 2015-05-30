function ordersInfoReady() {
  $('#order_quantity').on('change', function(foo, bar, baz) {
    var quantity = $('#order_quantity').val()
    $('#order-total-cost').val(quantity * 10)
  })
}

$(document).ready(ordersInfoReady)
$(document).on('page:load', ordersInfoReady)
