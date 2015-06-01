function homeReady() {
  pusherChannel.bind('sale_update', function(event) {
    $('#home-sold').text('Sold ' + event.total + ' bottles')
  })
  
  pusherChannel.bind('shipped_update', function(event) {
    $('#home-shipped').text('Shipped ' + event.total + ' bottles')
  })
}

$(document).ready(homeReady)
$(document).on('page:load', homeReady)
