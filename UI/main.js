
window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "ShowUI") {
        $('.Main').show();
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

$(document).on('click', '.ExitButton', function() {
    $.post(`https://${GetParentResourceName()}/CloseUI`, JSON.stringify({
        exit: true
    }));
    $('.RewardSelection').show();
    $('.RewardConfirmation').hide();
    $('.Main').hide();
});
