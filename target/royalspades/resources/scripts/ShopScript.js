/**
 * Created by Artwar on 2014-02-19.
 */
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
            price: JSON.stringify({storePrice: rawFormData[2].value})
        };
        console.log(data);
        addStoreProduct(data);
    });
});
function createCategorySelect(selected){
    //console.log("createCategorySelect");
    var html = '<select name="category">';
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
        url: '/api/store/'+id+'/',
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
            var selector = $(".productTable tbody");
            selector.empty();
            for(var i = 0; i < arr.length; i++){
                //console.log(arr[i]);
                var row = '<tr>' +
                    '<td><a href="#"><i class="fa fa-sort-down"></i></a></td>' +
                    '<td><a href="#"><i class="fa fa-sort-up"></i></a></td>' +
                    '<td>';
                row += arr[i]["product"]["name"];
                row +=  '</td><td>';
                row +=  arr[i]["category"]["name"];
                row +=  '</td><td>';
                row +=  arr[i]["price"];
                row +=  '</td><td>' +
                    '<!--suppress HtmlUnknownTarget --><a href="editShop/?id=' + arr[i].id + '"><i class="fa fa-edit"></i></a>' +
                    '</td></tr>';

                selector.append(row);
            }
        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function setStoreNewProductBrandSelect(){
    $.ajax({
        type: "GET",
        url: "/api/brand/all/",
        headers: {
            'Accept':"application/json",
            'Content-Type':"application/json"
        },
        dataType: "text",
        success: function (data) {
            data = parseJSON(data);
            //console.log(data);
            //var arr = JSON.parse([data]);

            //$(".shopTable").append("<tbody>");
            var selector = $('#selectNewProductsBrand');
            selector.empty();
            for(var i = 0; i < data.length; i++){
                var row = '<option value="'+data[i]['id']+'">';
                row +=  data[i]["name"];
                row +=  '</option>';

                selector.append(row);
            }

            $(document).on("click", "#selectNewProductsBrand option", function(event){
                //console.log(event.currentTarget.value);
                for (var i = 0; i < data.length; i++){
                    var d = data[i];
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
                        var row = '<option value="'+product['id']+'">';
                        row +=  product["name"];
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
        url: "/api/category/all/",
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
    var storeID = 2;
    var productID = storeProduct.store;
    var categoryID = storeProduct.category;
    var price = storeProduct.price;
    price = "";
    // /api/product/add_product_to_store/{storeId}/product/{productId}/store_category/{storeCategory}
    var url = '/api/product/add_product_to_store/'+storeID+'/product/'+productID+'/store_category/'+categoryID;

    $.post(url, price, function Success(data, textStatus){
        console.log(data);
        console.log(textStatus);
    });

}