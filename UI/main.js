window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.showUI) {
        $('.MainPage').show();
    } else {
        $('.MainPage').hide();
    }
});