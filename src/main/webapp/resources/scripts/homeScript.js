/**
 * Created by Artwar on 2014-03-11.
 */
var timesToGo = 0;
var volumes = [];
var productIds = [];

function preZero(s){
    s += "";
    if(s.length < 2){
        s = "0" + s;
    }
    return s;
}
function start(username){
    var d = new Date();
    $("input[name$='date']")
        .val(d.getFullYear() + "-" +
            preZero(d.getMonth()+1) + "-" +
            preZero(d.getDate()) + " " +
            preZero(d.getHours()) + ":" +
            preZero(d.getMinutes()))
        .prop('disabled', true);

    $.getJSON(baseUrl+"/api/user/" + username)
        .done(function(data) {
            $($("input[name='userId']")).val(data.id);
        })
        .fail(function(jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            $('#accountError').text("N�got gick fel: " + err);
        });


    $.ajax({
        type: "GET",
        url: baseUrl+"/api/product/all/",
        dataType: "text",
        success: function (data) {
            var arr = parseJSON(data);

            var html = "<tbody>";
            for(var i = 0; i < arr.length; i++){
                var product = arr[i];
                var row = "<tr><td>";
                row += '<input type="hidden" class="productId" id="' + product.id + '">';
                row += product.name;
                row += '</td><td style="text-align:right;">';
                row += product.volume;
                row += "</td><td>";
                row += product.unit;
                row += "</td><td>";
                row += product.brand.name;
                row += "</td><td>";
                row += product.category.name;

                row += '<td style="text-align:center;"><select class="quantity"></select></td>';
                row += '</td><td style="text-align:center;">';
                row += '<input type="checkbox" class="product_check">';
                row += "</td></tr>";
                html += row;
            }

            html += "</tbody>";

            $(".groceryTable").append(html);
            for(var l = 1; l < 11; l++){
                $(".quantity").append( // Append an object to the inside of the select box
                    $("<option value='"+(l+1)+"'></option>")
                        .text(l)
                        .val(l)
                );
            }
            $(".quantity").val("-");

            $('.groceryTable').dataTable({
                "aLengthMenu": [
                    [25, 50, 100, -1],
                    [25, 50, 100, "All"]],
                "iDisplayLength" : -1,
                "bScrollInfinite": true,
                "bScrollCollapse": false,
                "sScrollY": "300px",
                "oLanguage": {
                    "sLengthMenu": "Visar _MENU_ produkter per sida",
                    "sZeroRecords": "Hittade inget - tyv�rr",
                    "sInfo": "Visar _START_ till _END_ av _TOTAL_ varor",
                    "sInfoEmpty": "Visar 0 av 0 varor",
                    "sInfoFiltered": "(filtrerat fr�n _MAX_ varor)",
                    "sSearch": "Filtrera: "
                }
            });
        },
        error: function (data, textStatus, jqXHR) {
            $('.error').text("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
// add each product to the list
function addProductToBag(productId, volume, listId){
    // will pass the form data and parse it to json string
    $.ajax({
        url:baseUrl+'/api/grocerylist/add_product_to_grocery_list/' + listId + '/product/' + productId,
        data: volume,
        contentType:'application/json',
        accept:'application/json',
        processData:false,
        type: 'PUT',
        complete: function(response) {
            if(response.status == 200){

                if(timesToGo > 1){
                    // reduce timesToGo and remove from array
                    timesToGo--;
                    productIds.splice(0,1);
                    volumes.splice(0,1);

                    // run ajax method again
                    addProductToBag(productIds[0], volumes[0], listId);
                } else {
                    // clear values
                    $(':input')
                        .not(':button, :submit, :reset, :hidden')
                        .val('')
                        .removeAttr('checked');
                    $('.response').text("Handlarlistan skapad!");
                }

            }

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
}
// run for every product
function addProductsToBags(listId){
    // get all selected values from checked checkboxes
    $('#dataTable').find('> tbody > tr').filter(':has(:checkbox:checked)').each(function() {

        // add to the number of times we need to run this
        timesToGo++;
        volumes.push(($(this).find("option:selected").val()));
        productIds.push(($(this).find("input").attr('id')));
    });

    // add each product to list
    addProductToBag(productIds[0], volumes[0], listId);
}
function createGroceryBag(userId, name){
    $.ajax({
        url:baseUrl+'/api/grocerylist/add_grocery_list/' + userId,
        data: '{"name":"' + name + '"}',
        contentType:'application/json',
        accept:'application/json',
        processData:false,
        type: 'POST',
        complete: function(response) {
            if(response.status == 200){
                // if the list was created then add products
                $('.response').text("L�gger till...");
                addProductsToBags(response.responseText);
            }

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
}
// Save grocery bag
$('#save').click(function() {
    $(".response").text("");
    $('.error').text("");

    var groceryBagName = ($('#groceryName').val());
    var userId = ($('#userId').val());


    if(groceryBagName.length > 2 && groceryBagName.length < 45){
        // create the grocery bag
        createGroceryBag(userId, groceryBagName);
    } else {
        $('.error').text("Namnet p� handlarlistan m�ste vara 2-45 tecken!");
    }

});