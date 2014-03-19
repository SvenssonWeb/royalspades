/**
 * Created by Artwar on 2014-03-11.
 */

function bindGroceryListMain(){
    $('#allGroceryListTable').on('click', '.fa-pencil', function(){
        groceryListID = $(this).data('productId');
    });
    $("#newGroceryBtn").on("click", function(){
        $(this).hide();
        $("#newGroceryForm").show();
    });
    $('#newGroceryForm').submit(function(e){
        e.preventDefault();
        var groceryList = {};
        groceryList.name = $(this).find('input').val();
        $.ajax({
            url:baseUrl+'/api/grocerylist/add_grocery_list/' + user.id,
            data: JSON.stringify(groceryList),
            contentType:'application/json',
            accept:'application/json',
            processData:false,
            type: 'POST',
            success: function(data, response) {
                console.log(data);
                if(response.status == 200){
                    // if the list was created then add products
                    $('.response').text("Lägger till...");
                }
                $('#newGroceryBtn').show();
                $("#newGroceryForm").find('input').val('');
                $("#newGroceryForm").hide();

                groceryList.id = data;
                groceryList.groceryListProducts = [];

                var row = createGroceryListTableRow(groceryList);

                $('#allGroceryListTable').find('tbody').append(row);
                //showMyGroceryLists(user.name);

            }, error: function(response){
                if(response.status != 200){
                    var responseJSON = response.responseJSON;

                    if(typeof responseJSON != 'undefined'){
                        var errors = '';

                        for(var i = 0; i < responseJSON.fieldErrors.length; i ++){
                            errors += (responseJSON.fieldErrors[i].message);
                            errors += '<br>';
                        }

                        $('.error').append(errors);

                    } else {
                        $('.error').text(response.responseText);
                    }
                }

            }
        });
    });
}