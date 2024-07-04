var Rewards = [];
var VehiclesFound = [];
var ItemsFound = [];

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "ShowUI") {
        $('.Main').show();
    }

    if (item.type === "UpdateRewards") {
        Rewards = item.rewards
        var VehicleList = $(".Vehicle-Table").find(".table");
        var MoneyList = $(".Money-Table").find(".table");
        var ItemList = $(".Item-Table").find(".table");
        VehicleList.empty();
        MoneyList.empty();
        ItemList.empty();
        $.each(Rewards, function(id, reward){
            if (reward.rewardType === "vehicle") {
                VehicleList.append(`
                    <tr class="table-row" rewardID = "${id}">
                        <td class="table-element">${reward.name}</td>
                    </tr>
                `);
            }
            else if (reward.rewardType === "money") {
                MoneyList.append(`
                    <tr class="table-row" rewardID = "${id}">
                        <td class="table-element">${reward.amount}$</td>
                    </tr>
                `);
            }
            else if (reward.rewardType === "item"){
                ItemList.append(`
                    <tr class="table-row" rewardID = "${id}">
                        <td class="table-element">${reward.amount} - </td>
                        <td class="table-element">${reward.label}</td>
                    </tr>
                `);
            }
        });
    }
    if (item.type === "displayVehicles"){
        VehiclesFound = item.vehicleList
        var VehicleTable = $(".SearchResults-Vehicles").find(".table");
        VehicleTable.empty();
        $.each(VehiclesFound, function(id, vehicle){
            if (id <= 5) {
                VehicleTable.append(`
                    <tr class="table-row-veh" vehicleID = "${id}">
                        <td class="table-element">${vehicle.name}</td>
                    </tr>
                `);
            }
        });
    }

    if (item.type === "displayItems"){
        ItemsFound = item.itemList
        var ItemsTable = $(".SearchResults-Items").find(".table");
        ItemsTable.empty();
        $.each(ItemsFound, function(id, listItem){
            if (id <= 5) {
                ItemsTable.append(`
                    <tr class="table-row-item" itemID = "${id}">
                        <td class="table-element">${listItem.label}</td>
                    </tr>
                `);
            }
        });
    }

    if (item.type === "CopyToClipboard"){
        copyToClipboard(item.string);
    }
});

function resetUI(){
    $('.RewardSelection').show();
    $('.RewardConfirmation').hide();
    $('.Vehicles-Section').show();
    $('.Items-Section').hide();
    $('.Money-Section').hide();
    $('#VehicleSearch').val("");
    $('#MoneyAmount').val("");
    $('#ItemSearch').val("");
    var VehicleList = $(".Vehicle-Table").find(".table");
    var MoneyList = $(".Money-Table").find(".table");
    var ItemList = $(".Item-Table").find(".table");
    var VehicleTable = $(".SearchResults-Vehicles").find(".table");
    var ItemsTable = $(".SearchResults-Items").find(".table");
    VehicleList.empty();
    MoneyList.empty();
    ItemList.empty();
    VehicleTable.empty();
    ItemsTable.empty();
    VehiclesFound = [];
    ItemsFound = [];
    Rewards = [];   

}

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



$(document).on('click', '#ConfirmVehicle', function() {
    var text = $('#VehicleSearch').val();
    $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
        action: "SearchVehicles",
        text: text
    }));
});

$(document).on('click', '#ConfirmItem', function() {
    var text = $('#ItemSearch').val();
    $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
        action: "SearchItems",
        text: text
    }));
});

$(document).on('click', '.table-row-veh', function() {
    var vehicleID = $(this).attr("vehicleID");
    $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
        action: "AddReward",
        id: 1,
        rewardType: "vehicle",
        name: VehiclesFound[vehicleID].name,
        model: VehiclesFound[vehicleID].model 
    }));
    Rewards.push(VehiclesFound[vehicleID]);
}); 
    
$(document).on('click', '.table-row-item', function() {
        var itemID = $(this).attr("itemID");
        $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
            action: "AddReward",
            id: 1,
            rewardType: "item",
            label: ItemsFound[itemID].label,
            amount: 1,
            name: ItemsFound[itemID].name,
        }));
        Rewards.push(ItemsFound[itemID]);
});

$(document).on('click', '#ConfirmMoney', function() {
    var amount = $('#MoneyAmount').val();
    $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
        action: "AddReward",
        id: 1,
        rewardType: "money",
        amount: amount
    }));
});

$(document).on('click', '#GenerateButton', function() {
    $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
        action: "GenerateCode",
    }));
});

$(document).on('click', '.ExitButton', function() {
    $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
        action: "CloseUI"
    }));
    resetUI();
    $('.Main').hide();
});

$(document).on('click', '#GenerateButton', function() {
    $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
        action: "CloseUI"
    }));
    resetUI();
    $('.Main').hide();
});

const copyToClipboard = str => {
    const el = document.createElement('textarea');
    el.value = str;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
 };

