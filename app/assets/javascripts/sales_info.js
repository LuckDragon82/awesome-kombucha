function salesInfoReady() {
  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message);
    }
  };

  var pusher = new Pusher('c26a1c6331c861eb0b91');
  var channel = pusher.subscribe('sales_channel');
  channel.bind('an_event', function(event) {
    alert(JSON.stringify(event))
  })
}

$(document).ready(salesInfoReady)
$(document).on('page:load', salesInfoReady)
