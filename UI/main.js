
window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.showUI) {
        $('.Main').show();
    } else {
        $('.Main').hide();
    }
});

