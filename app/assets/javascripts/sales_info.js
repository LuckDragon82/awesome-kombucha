function salesInfoReady() {
  pusherChannel.bind('order', function(event) {
    $('.sales-list').prepend("<li class='list-group-item'>" + event.first_name + " " + event.last_name + " from " + event.city + ", " + event.country + " just bought " + event.quantity +  " bottles of Awesome Kombucha </li>")
  })
}

$(document).ready(salesInfoReady)
$(document).on('page:load', salesInfoReady)
