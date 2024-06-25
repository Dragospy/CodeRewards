
window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.showUI) {
        $('.Main').show();
    } else {
        $('.Main').hide();
    }
});

$(document).on('click', '#VehiclesButton', function() {
    $('.Vehicles-Section').show();
    $('.Items-Section').hide();
    $('.Money-Section').hide();
});

$(document).on('click', '#MoneyButton', function() {
    $('.Vehicles-Section').hide();
    $('.Items-Section').hide();
    $('.Money-Section').show();
});

$(document).on('click', '#ItemsButton', function() {
    $('.Vehicles-Section').hide();
    $('.Items-Section').show();
    $('.Money-Section').hide();
});

$(document).on('click', '#Summary', function() {
    $('.RewardSelection').hide();
    $('.RewardConfirmation').show();
});
