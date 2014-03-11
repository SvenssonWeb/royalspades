/**
 * Created by Artwar on 2014-03-11.
 */
var user;
var timesToGo = 0;
var volumes = [];
var productIds = [];

$(document).on('click', '.shopRemoveRow', function(){
    var productId = $(this).data('productId');
    console.log('id: ' + productId);
    removeGroceryList(productId);
});
function preZero(s){
    s += "";
    if(s.length < 2){
        s = "0" + s;
    }
    return s;
}


function homeStart(username){
    getUserFromUsername(username, function(id){
        getAllGroceryLists(id)
    });
}
function getUserFromUsername(username, successFunction){
    $.getJSON(baseUrl+"/api/user/" + username)
        .done(function(data) {
            user = data;
            $($("input[name='userId']")).val(data.id);
            if(successFunction) successFunction(data.id);
        })
        .fail(function(jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            $('#accountError').text("N�got gick fel: " + err);
        });
}



function getAllGroceryLists(userID){
    //api/grocerylist/user/{userId}
    $.ajax({
        type: "GET",
        url: baseUrl+"/api/grocerylist/user/"+userID,
        dataType: "text",
        success: function (data) {
            var arr = parseJSON(data);
            console.log(arr);
            createGroceryListTable(arr);
        },
        error: function (data, textStatus, jqXHR) {
            $('.error').text("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function createGroceryListTable(arr){
    var table = $("#allGroceryListTable").find("tbody");
    var html = "";
    for(var i = 0; i < arr.length; i++){
        var groceryList = arr[i];
        console.log(groceryList);
        var row = '<tr>';
        row += '<td>2014-01-22 09:45</td>';
        row += '<td>'+groceryList.name+'</td>';
        row += '<td>'+groceryList['groceryListProducts'].length+'</td>';

        row += '<td><a class="link"  href="/home/editgrocerybag?id='+groceryList.id+'">' +
                    '<i data-product-id="'+groceryList.id+'" class="fa fa-pencil point"></i>' +
                '</a></td>';
        row += '<td><i data-product-id="'+groceryList.id+'" class="fa fa-times shopRemoveRow"></i></td>';
        row += '</tr>';
        html += row;
    }
    table.html(html);
}
function removeGroceryList(id){
    //api/grocerylist/remove_grocery_list/{listId}
    $.ajax({
        type: "DELETE",
        url: baseUrl+"/api/grocerylist/remove_grocery_list/"+id,
        dataType: "text",
        success: function () {
            getAllGroceryLists(user.id);
        },
        error: function (data, textStatus, jqXHR) {
            $('.error').text("Error: " + textStatus + ", " + jqXHR);
        }
    });
}