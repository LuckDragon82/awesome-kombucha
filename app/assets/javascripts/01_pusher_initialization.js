var pusherChannel
function pusherInitialization() {
  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message)
    }
  }

  var pusher = new Pusher('c26a1c6331c861eb0b91')
  pusherChannel = pusher.subscribe('sales_channel')
}

$(document).ready(pusherInitialization)
$(document).on('page:load', pusherInitialization)
  