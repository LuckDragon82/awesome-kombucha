function salesInfoReady() {
  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message)
    }
  }

  var pusher = new Pusher('c26a1c6331c861eb0b91')
  var channel = pusher.subscribe('sales_channel')
  channel.bind('order', function(event) {
    $('.sales-list').prepend("<li class='list-group-item'>" + event.first_name + " " + event.last_name + " from " + event.country + " just bought " + event.quantity +  " bottles of Awesome Kombucha </li>")
  })
}

$(document).ready(salesInfoReady)
$(document).on('page:load', salesInfoReady)
