var orderItems = window.orderItems || [];
var vm = new Vue({
  el: '#items',
  data: {
    items: orderItems
  }
});
