/**
 * Created by Artwar on 2014-02-19.
 */
var currentStore;
$.ajaxSetup({
    Accept:"application/json",
    contentType: "application/json; charset=utf-8",
    dataType:'text'
});
var allProducts;
var allCategories;
var storeProducts;

$( document).on("click", "#shopProductCreateNew", function(){
    $(".shopProductPage").slideUp();
    $("#shopSelectNewContainer").slideDown();

    $("#shopProductCreateNew").addClass('active');
    $("#shopProductShow").removeClass('active');
});
$( document).on("click", "#shopProductShow", function(){
    setStoreProductTable(currentStore.id);
    $(".shopProductPage").slideDown();
    $("#shopSelectNewContainer").slideUp();

    $("#shopProductCreateNew").removeClass('active');
    $("#shopProductShow").addClass('active');
});
$( document).on("click", "#shopTableNewProducts .shopRemoveRow", function(){
    $(this).closest('tr').remove();
});
$( document).on("click", "#shopNewProductsAdd", function(){
    var selected = $("#selectNewProducts").val();
    var tableBody = $(".shopTableNewProducts tbody");

    var priceCell = '<td><input class="priceInput" name="storePrice" placeholder="Pris"></td>';
    var deleteIconCell = '<td><i class="fa fa-times shopRemoveRow"></i></td>';

    //tableBody.empty();
    //console.log(allProducts);

    for (var i = 0; i < selected.length; i++) {

        for (var j = 0; j < allProducts.length; j++) {
            if (selected[i] == allProducts[j]['id']){
                var d = allProducts[j];
                if(tableBody.find('input[value="'+d['id']+'"]').length == 0){
                    //console.log(d);
                    var row = '<tr><form>' +
                        '<input type="hidden" name="id" value="'+d['id']+'">' +
                        '<td>'+d['brand']['name']+'</td>' +
                        '<td>'+d['name']+'</td>' +
                        '<td>'+createCategorySelect(d['category']['id'])+'</td>' +
                        priceCell + deleteIconCell + '</form></tr>';
                    tableBody.append(row);
                }
                break;
            }
        }
    }
});
$( document).on("click", "#shopFormNewProducts button", function(event){
    event.preventDefault();
    var select = $("#shopTableNewProducts").find("form");
    console.log(select);
    select.each(function(){
        var rawFormData = $(this).serializeArray();
        console.log(rawFormData);
        var data = {
            store: rawFormData[0].value,
            category: rawFormData[1].value,
            price: rawFormData[2].value
        };
        console.log(data);
        addStoreProduct(data);
        $("#shopFormNewProducts").find('tbody').empty();
    });
});
$( document).on("click", '.shopProductPage .shopRemoveRow', function(event){
    console.log($(this).data());
    var dataString = $(this).data().productId;
    var dataArray = dataString.split('-');
    var url = baseUrl+'/product/remove_product_from_store/'+dataArray[0]
                +'/product/'+dataArray[1]+'/category/'+dataArray[2];
    if(!confirm('Du kommer nu ta bort produkten?')){
        return;
    }
    $.ajax({
        type: "DELETE",
        url: url,
        headers: {
            'Accept':"application/json",
            'Content-Type':"application/json"
        },
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            console.log(textStatus);
        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
    $(this).closest('tr').remove();

});
$( document).on("click", '.shopProductPage .fa-pencil', function(){
    var editContainer = $("#shopEditContainer");
    editContainer.show();
    var editedRow = $(this).parents('tr');
    var price = $(editedRow.children('td')[4]).text();
    var productName = $(editedRow.children('td')[2]).text();
    var storeProduct = $(this).data().productId.split('-');
     console.log(price);
    editContainer.find('#categorySelect').empty().append(createCategorySelect(storeProduct[2]));
    var categEle = editContainer.find('[name="category"]');
    var priceEle = editContainer.find('[name="price"]').val(price);
    var spid = storeProduct[0] +'-'+ storeProduct[1] +'-'+ categEle.find(':selected').val();

    editContainer.on('click', 'button', function(e){
        e.preventDefault();
        var row = createStoreProductRow(productName,categEle.find(':selected').text(), priceEle.val(), spid);
        $(row).replaceAll(editedRow);
        editContainer.hide();
    });
});
function start(userName){
    $.ajax({
        type: "GET",
        url: baseUrl+'/api/store/all/',
        headers: {
            'Accept':"application/json",
            'Content-Type':"application/json"
        },
        dataType: "text",
        success: function (data) {
            var stores = parseJSON(data);
            for(var i = 0; i < stores.length; i++){
                var store = stores[i];
                var user = store['user'];
                if(userName == user['username']){
                    currentStore = store;
                }
            }
            setStoreAllProducts();

            setStoreProductTable(currentStore.id);

            setStoreNewProductBrandSelect();

            setStoreCategoriesTable();
        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function createCategorySelect(selected){
    //console.log("createCategorySelect");
    var html = '<select name="category">';
    html+= '<option>Välj en kategori</option>';
    for (var i = 0; i < allCategories.length; i++) {
        var d = allCategories[i];
        var select = (selected == d['id']) ? "selected" : "";
        html += '<option ' + select + ' value="' + d['id'] + '">' + d['name'] + '</option>';
    }
    html += '</select>';
    return html;
}
function setStoreAllProducts() {
    $.ajax({
        type: "GET",
        url: "/api/product/all/",
        headers: {
            'Accept':"application/json",
            'Content-Type':"application/json"
        },
        dataType: "text",
        success: function (data) {
            allProducts = parseJSON(data);
        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function setStoreProductTable(id){
    $.ajax({
        type: "GET",
        url: baseUrl+'/api/store/'+id+'/',
        headers: {
            'Accept':"application/json",
            'Content-Type':"application/json"
        },
        dataType: "text",
        success: function (data) {
            //console.log(data);
            data = parseJSON(data);
            var arr = data["storeProduct"];
            storeProducts = arr;
            $("#shopName").html(data["name"]);
            $("#shopAddress").html(data["address"]);

            //$(".shopTable").append("<tbody>");
            var tableBody = $(".productTable tbody");
            tableBody.empty();
            var fullHTML = "";
            for(var i = 0; i < arr.length; i++){
                var rowData = arr[i];
                var productInfo = rowData["product"]["name"] + ' ' + rowData["product"]["volume"] + rowData["product"]["unit"];
                var rowID = currentStore.id + '-'
                    + rowData['product']['id'] + '-'
                    + rowData['category']['id'];

                var row = '<tr>' +
                            '<td><a href="#"><i class="fa fa-sort-down"></i></a></td>' +
                            '<td><a href="#"><i class="fa fa-sort-up"></i></a></td>' +
                            '<td>'+productInfo+'</td>' +
                            '<td>'+rowData["category"]["name"]+'</td>' +
                            '<td>'+rowData["price"]+'</td>' +
                            '<td><i data-product-id="'+rowID+'" class="fa fa-pencil point"></i></td>' +
                            '<td><i data-product-id="'+rowID+'" class="fa fa-times shopRemoveRow"></i></td>';
                row += '</tr>';
                //fullHTML += row;
                fullHTML += createStoreProductRow(productInfo, rowData['category']['name'], rowData['price'], rowID);
                //tableBody.append(row);
            }
            tableBody.append(fullHTML);
        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function createStoreProductRow(productText, categoryName, price, id){
    var row = '<tr>' +
                '<td><a href="#"><i class="fa fa-sort-down"></i></a></td>' +
                '<td><a href="#"><i class="fa fa-sort-up"></i></a></td>' +
                '<td>'+productText+'</td>' +
                '<td>'+categoryName+'</td>' +
                '<td>'+price+'</td>' +
                '<td><i data-product-id="'+id+'" class="fa fa-pencil point"></i></td>' +
                '<td><i data-product-id="'+id+'" class="fa fa-times shopRemoveRow"></i></td>';
    row += '</tr>';
    return row;
}
function setStoreNewProductBrandSelect(){
    $.ajax({
        type: "GET",
        url: baseUrl+"/api/brand/all/",
        headers: {
            'Accept':"application/json",
            'Content-Type':"application/json"
        },
        dataType: "text",
        success: function (ajaxData) {
            var localData = parseJSON(ajaxData);
            //console.log(data);
            //var arr = JSON.parse([data]);

            //$(".shopTable").append("<tbody>");
            var selector = $('#selectNewProductsBrand');
            selector.empty();
            for(var i = 0; i < localData.length; i++){
                var row = '<option value="'+localData[i]['id']+'">';
                row +=  localData[i]["name"];
                row +=  '</option>';

                selector.append(row);
            }

            $(document).on("click", "#selectNewProductsBrand option", function(event){
                //console.log(event.currentTarget.value);
                for (var i = 0; i < localData.length; i++){
                    var d = localData[i];
                    // if fetched brand id == brand select id
                    if(d['id'] == event.currentTarget.value){
                        createBrandProductsSelect(d);
                        return;
                    }
                }
            });
            function createBrandProductsSelect(brand){
                var selector = $("#selectNewProducts");
                selector.empty();
                if (brand['brandProducts'].length == 0) {
                    selector.append('<option>Inga Producter</option>');
                    //return;
                }
                for (var j = 0; j < brand['brandProducts'].length; j++) {
                    var product = brand['brandProducts'][j];
                    if(!checkStoreHasProduct(product)){

                        var text = product['name'] + ' ' + product['volume'] + ' ' + product['unit'];

                        var row = '<option value="'+product['id']+'">';
                        row +=  text;
                        row +=  '</option>';

                        selector.append(row);
                        row = undefined;
                    }
                }
            }
            function checkStoreHasProduct(product){
                for(var i = 0; i < storeProducts.length; i++){
                    if(storeProducts[i]['product']['id'] == product['id']) return true;
                }
                return false;
            }

        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function setStoreCategoriesTable() {
    $.ajax({
        type: "GET",
        url: baseUrl+"/api/category/all/",
        headers: {
            'Accept': "application/json",
            'Content-Type': "application/json"
        },
        dataType: "json",
        success: function (data) {
            allCategories = data;
            //console.log(data);
            //data = parseJSON(data);


            var selector = $(".categoryTable tbody");
            selector.empty();
            for (var i = 0; i < data.length; i++) {
                var row = '<tr>' +
                    '<td><a href="#"><i class="fa fa-sort-down"></i></a></td>' +
                    '<td><a href="#"><i class="fa fa-sort-up"></i></a></td>' +
                    '<td>';
                row += data[i]["name"];
                row += '</td></tr>';

                selector.append(row);
            }
        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}

function addStoreProduct(storeProduct){
    var storeID = currentStore.id;
    var productID = storeProduct.store;
    var categoryID = storeProduct.category;
    var price = storeProduct.price;
    // /api/product/add_product_to_store/{storeId}/product/{productId}/store_category/{storeCategory}
    var url = baseUrl+'/api/product/add_product_to_store/'+storeID+'/product/'+productID+'/store_category/'+categoryID;

    $.post(url, price, function Success(data, textStatus){
        console.log(data);
        console.log(textStatus);
    });

}

function changeStoreProduct(){
    var storeId;
    var productId;
    var oldCatId;
    var newCatId;
    var price;
    var url = baseUrl+'/api/product/remove_product_from_store/{storeId}/product/{productId}/category/{categoryId}';
}

