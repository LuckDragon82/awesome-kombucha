function homeReady() {
  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message)
    }
  }

  var pusher = new Pusher('c26a1c6331c861eb0b91')
  var channel = pusher.subscribe('sales_channel')
  channel.bind('sale_update', function(event) {
    $('#home-sold').text('Sold ' + event.total + ' bottles')
  })
  
  channel.bind('shipped_update', function(event) {
    $('#home-shipped').text('Shipped ' + event.total + ' bottles')
  })
}

$(document).ready(homeReady)
$(document).on('page:load', homeReady)
