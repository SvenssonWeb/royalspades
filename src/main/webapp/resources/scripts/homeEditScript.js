/**
 * Created by Artwar on 2014-03-11.
 */
function startEditGroceryList(username){
    groceryStart(username, function(){
        getGroceryListsById(user.id);
    });
}
function getGroceryListsById(id){
    $.ajax({
        type: "GET",
        url: baseUrl+"/api/grocerylist/user/"+id,
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