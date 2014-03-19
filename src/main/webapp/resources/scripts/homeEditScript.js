/**
 * Created by Artwar on 2014-03-11.
 */
$(document).on("click", '.moveIt', function (event)
{
    // Get the id of the clicked table for comparison
    var id = $(this).closest('table').attr('id');

    // Assign the tables to the table object
    var table = {
        from : (id === 'groceryListAddedProducts') ? oTable1 : oTable2,
        to : (id !== 'groceryListAddedProducts') ? oTable1 : oTable2
    };
    // Instead of calling the tables in seperate functions just use the  dynamically
    // assigned table.added.x() and table.all.x()
    var row = $(this).closest("tr").get(0);
    moveRow(table.from, table.to, row);

});
function bindSaveButton(){
    $('#save').click(function() {
        console.log("save");
        $(".response").text("");
        var $error = $('.error');
        $error.text("");

        var groceryBagName = ($('#groceryName').val());
        var groceryBagId = ($('#groceryListId').val());
        var rows = $('#groceryListAddedProducts').find('tbody tr');
        var products = [];
        for (var i = 0; i < rows.length; i++) {
            var row = rows[i];

            var product = {};
            product.id = $(row).find('input').val();
            product.volume = $(row).find('select').val();
            products.push(product);
        }
        var url = "/api/grocerylist/add_products_to_grocery_list/";
        console.log(products);
        console.log(JSON.stringify(products));

        $.ajax({
            type: "PUT",
            url: baseUrl+url+groceryBagId,
            contentType:"application/json",
            dataType: "text",
            data:JSON.stringify(products),
            success: function (data) {
                //var arr = parseJSON(data);
                console.log(data)
            },
            error: function (data, textStatus, jqXHR) {
                $('.error').text("Error: " + textStatus + ", " + jqXHR);
            }
        });
        if(groceryBagName.length > 2 && groceryBagName.length < 45){
            // create the grocery bag
        } else {
            $error.text("Namnet på handlarlistan måste vara 2-45 tecken!");
        }
    });
}
function createNewDate(){
    var d = new Date();
    $("input[name$='date']")
        .val(d.getFullYear() + "-" +
            preZero(d.getMonth()+1) + "-" +
            preZero(d.getDate()) + " " +
            preZero(d.getHours()) + ":" +
            preZero(d.getMinutes()))
        .prop('disabled', true);

}
function getAllProducts(end){
    $.ajax({
        type: "GET",
        url: baseUrl+"/api/product/all/",
        dataType: "text",
        success: function (data) {
            var arr = parseJSON(data);

            end(arr);
        },
        error: function (data, textStatus, jqXHR) {
            $('.error').text("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function showProductsTables(username){
    groceryStart(username, function(){
        getGroceryListsById(groceryListID);
    });
}
function groceryStart(username, end){
    // Save grocery bag
    bindSaveButton();
    createNewDate();

    var success = function(arr){
        createGroceryTable(arr);
        enhanceGroceryBothTables();
        if(end) end();
    };
    if(!user) getUserFromUsername(username, function(){
        getAllProducts(success);
    });

    getAllProducts(success);
}
function createGroceryTable(arr){
    var html = "<tbody>";
    for(var i = 0; i < arr.length; i++){
        var product = arr[i];

        html += createGroceryTableRow(product);
    }

    html += "</tbody>";
    $("#groceryListAllProducts").append(html);
    var options = "";
    for(var l = 1; l < 11; l++){
        options += "<option value='"+l+"'>"+l+"</option>"
    }
    $(".quantity").append(options).val("-");
}
function createGroceryTableRow(product){
    var row = '<tr>' +
        '<td>';
    row += '<i class="fa fa-arrow-left moveIt"></i></td><td>';
    row += '<input type="hidden" name="id" value="' + product.id + '">' + product.name;

    row += '</td><td>';
    row += product.volume + product.unit;
    row += "</td><td>";
    row += product.unit;
    row += "</td><td>";
    row += product['brand'].name;
    row += "</td><td>";
    row += product.category.name;

    row += '<td><select name="quantity" class="quantity"></select></td>';
    row += '</td><td><i class="fa fa-arrow-right moveIt"></i>';
    row += "</td></tr>";
    return row;
}
function getGroceryListsById(id){
    $.ajax({
        type: "GET",
        url: baseUrl+"/api/grocerylist/"+id,
        dataType: "text",
        success: function (data) {
            var groceryList = parseJSON(data);
            $('#groceryName').val(groceryList.name);
            $('#groceryListId').val(groceryList.id);

            console.log(groceryList);
            var groceryListProducts = groceryList.groceryListProducts;
            var ids = [];
            var values = [];
            for(var i = 0; i < groceryListProducts.length; i++ ){
                var prod = groceryListProducts[i];
                ids.push(prod.product.id);
                values.push(prod.volume);
            }
            console.log(ids);
            populateAddedTable(ids, values)

        },
        error: function (data, textStatus, jqXHR) {
            $('.error').text("Error: " + textStatus + ", " + jqXHR);
        }
    });
}

function enhanceGroceryBothTables(){
    enhanceGroceryAddedTable();
    enhanceGroceryAllTable();
}
var oTable1;
var oTable2;
function enhanceGroceryAddedTable(){
    oTable1 = $('.groceryListAddedProducts table').dataTable({
        "aLengthMenu": [
            [25, 50, 100, -1],
            [25, 50, 100, "All"]],
        "bLengthChange": false,
        "iDisplayLength" : -1,
        "bScrollInfinite": false,
        "bScrollCollapse": false,
        "oLanguage": {
            "sLengthMenu": "Visar _MENU_ produkter per sida",
            "sZeroRecords": "Hittade inget - tyvärr",
            "sInfo": "Visar _START_ till _END_ av _TOTAL_ varor",
            "sInfoEmpty": "Visar 0 av 0 varor",
            "sInfoFiltered": "(filtrerat från _MAX_ varor)",
            "sSearch": "Filtrera: ",
            "oPaginate": {
                "sPrevious": "Föregående",
                "sNext":"Nästa"
            }
        },
        "aoColumns": [
            { "bSearchable": false, "bVisible": false },
            null,
            null,
            { "bVisible": false },
            null,
            null,
            { "bSearchable": false },
            { "bSearchable": false}
        ]
    });
}
function enhanceGroceryAllTable(){
    oTable2 = $('.groceryListAllProducts table').dataTable({
        "aLengthMenu": [
            [25, 50, 100, -1],
            [25, 50, 100, "All"]],
        "bLengthChange": false,
        "iDisplayLength" : -1,
        "bScrollInfinite": false,
        "bScrollCollapse": false,
        "oLanguage": {
            "sLengthMenu": "Visar _MENU_ produkter per sida",
            "sZeroRecords": "Hittade inget - tyvärr",
            "sInfo": "Visar _START_ till _END_ av _TOTAL_ varor",
            "sInfoEmpty": "Visar 0 av 0 varor",
            "sInfoFiltered": "(filtrerat från _MAX_ varor)",
            "sSearch": "Filtrera: ",
            "oPaginate": {
                "sPrevious": "Föregående",
                "sNext":"Nästa"
            }
        },
        "aoColumns": [
            { "bSearchable": false},
            null,
            null,
            { "bVisible": false },
            null,
            null,
            { "bSearchable": false, "bVisible": false },
            { "bSearchable": false, "bVisible": false  }
        ]
    });
}
function moveRow(from, to, row){
    var addElement = from.fnGetData(row);
    to.fnAddData(addElement);
    var removeElement = to.fnGetPosition(row);
    from.fnDeleteRow(removeElement, null, true);

    oTable1.fnDraw();
    oTable2.fnDraw();

}
function populateAddedTable(ids, values){
    var tableRows = $("#groceryListAllProducts").find("tr");
    for(var i = 0; i < tableRows.length; i++){
        var row = tableRows[i];
        var id = $(row).find('input[name="id"]').val();
        id = parseInt(id);
        var j = ids.indexOf(id);
        if (j != -1){
            $(row).find(".fa-arrow-left.moveIt").click();
        }
    }
    setValuesInAddedTable(ids,values);
}
function setValuesInAddedTable(ids, values){
    var tableRows = $("#groceryListAddedProducts").find("tr");
    for(var i = 0; i < tableRows.length; i++){
        var row = tableRows[i];
        var id = $(row).find('input[name="id"]').val();
        id = parseInt(id);
        var j = ids.indexOf(id);
        if (j != -1){
            $(row).find("select").val(values[j]);
        }
    }
}