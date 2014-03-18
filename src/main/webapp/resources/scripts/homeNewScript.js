/**
 * Created by Artwar on 2014-03-11.
 */

function bindGroceryListMain(){
    $('#allGroceryListTable').on('click', '.fa-pencil', function(){
        var link = $(this).parent('a').prop('href');
        groceryListID = link.split('=')[1];
    });
    $("#newGroceryBtn").on("click", function(){
        $(this).hide();
        $("#newGroceryForm").show();
    });
    $('#newGroceryForm').submit(function(e){
        e.preventDefault();
        var name = {};
        name.name = $(this).find('input').val();
        $.ajax({
            url:baseUrl+'/api/grocerylist/add_grocery_list/' + user.id,
            data: JSON.stringify(name),
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

                var row = '<tr>';
                row += '<td>2014-01-22 09:45</td>';
                row += '<td>'+name.name+'</td>';
                row += '<td>0</td>';

                row += '<td><a class="link"  href="/home/editgrocerybag?id='+data+'">' +
                    '<i data-product-id="'+data+'" class="fa fa-pencil point"></i>' +
                    '</a></td>';
                row += '<td><i data-product-id="'+data+'" class="fa fa-times shopRemoveRow"></i></td>';
                row += '</tr>';
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