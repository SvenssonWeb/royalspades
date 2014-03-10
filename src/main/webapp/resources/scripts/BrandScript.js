/**
 * Created by Artwar on 2014-02-19.
 */
var currentBrand;
$.ajaxSetup({
    Accept:"application/json",
    contentType: "application/json; charset=utf-8",
    dataType:'text'
});
var allProducts;
var allCategories;
var storeProducts;

$( document).on("click", "#brandSubmit", function(e){
    e.preventDefault();
    var form = $("form#brandAddNewProduct");
    var tableBody = $(".brandAllProductsTable tbody");
    var data = form.serializeObject();
    if(data.id == ""){
        createNewProduct(data.name, data.volume, data.unit, currentBrand, data.category,
            function(){
                form[0].reset();
                form.find('[type="hidden"]').val("");
            });

    } else {
        console.log(data);
        updateProduct(data, function(){
            form[0].reset();
            form.find('[type="hidden"]').val("");
            $("#brandSubmit").val("Lägg till")
        });
    }


});

$( document).on("click", '.brandAllProductsTable .shopRemoveRow', function(event){
    console.log($(this).data());
    var dataString = $(this).data().productId;
    var url = '/api/product/remove_product/'+dataString;
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

$(document).on("click", "#clearEdit", function(e){
    e.preventDefault();
    var cont = $(".newWare.brandContainer");
    cont.find("legend").text("Ny vara");
    $("#brandSubmit").val("Lägg till");
    cont.find("form")[0].reset();
    cont.find('form [type="hidden"]').val("");
    $(this).hide();
});
$( document).on("click", '.brandAllProductsTable .fa-pencil', function(){
    var cont = $(".newWare.brandContainer");
    $("#brandSubmit").val("Spara");
    $("#clearEdit").show();
    cont.find("legend").text("Redigera Vara");
    var product;
    var id = $(this).data().productId;
    for(var i = 0, length = allProducts.length; i < length; i++){
        if(allProducts[i].id == id){
            product = allProducts[i];
            break;
        }
    }
    console.log(product);
    var editContainer = $("#brandAddNewProduct");
    var ele = {
        id:editContainer.find('[name="id"]'),
        name:editContainer.find('[name="name"]'),
        volume:editContainer.find('[name="volume"]'),
        unit:editContainer.find('[name="unit"]'),
        category:editContainer.find('[name="category"]')
    };
    ele.id.val(product.id);
    ele.name.val(product.name);
    ele.volume.val(product.volume);
    ele.unit.val(product.unit);
    ele.category.val(product.category.id);

});
function start(userName){
    $.ajax({
        type: "GET",
        url: '/api/brand/all/',
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
                    currentBrand = store;
                }
            }
            getBrandAllProducts();
            getAllCategories();
            // $(createCategorySelect()).replaceAll('#category');

            setBrandProductTable(currentBrand.id);


        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function updateProduct(product, success) {
    var url = '/api/product/edit_brand_product/category/'+product.category+'/brand/'+currentBrand.id;
    var data = {id:product.id,name:product.name,volume:product.volume,unit:product.unit};
    $.ajax({
        type: "PUT",
        url: url,
        data: JSON.stringify(data),
        complete: function(data, textStatus){
            console.log(data);
            console.log(textStatus);
            setBrandProductTable(currentBrand.id);
            success();
        }
    });
}
function createNewProduct(name, volume, unit, brand, category, success){

    var url = baseUrl+ '/api/product/add_product/category/'+category+'/brand/'+brand.id;
    var data = {name:name,volume:volume,unit:unit};
    $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(data),
        complete: function(data, textStatus){
            console.log(data);
            console.log(textStatus);
            setBrandProductTable(currentBrand.id);
            success();
        }
    });

    /*$.post(url, data, function success(data, textStatus){
        console.log(data);
        console.log(textStatus);
        //return createBrandProductRow(name, category.name, data.id);
        setBrandProductTable(currentBrand);
    });    */
}
function createCategorySelect(selected){
    //console.log("createCategorySelect");
    var html = '<select id="category" name="category">';
    html+= '<option>Välj en kategori</option>';
    for (var i = 0; i < allCategories.length; i++) {
        var d = allCategories[i];
        var select = (selected == d['id']) ? "selected" : "";
        html += '<option ' + select + ' value="' + d['id'] + '">' + d['name'] + '</option>';
    }
    html += '</select>';
    return html;
}
function getBrandAllProducts() {
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
function setBrandProductTable(id){
    $.ajax({
        type: "GET",
        url: '/api/brand/'+id+'/',
        headers: {
            'Accept':"application/json",
            'Content-Type':"application/json"
        },
        dataType: "text",
        success: function (data) {
            //console.log(data);
            data = parseJSON(data);
            var arr = data["brandProducts"];
            allProducts = arr;
            storeProducts = arr;
            $("#shopName").html(data["name"]);
            $("#shopAddress").html(data["address"]);

            //$(".shopTable").append("<tbody>");
            var tableBody = $(".brandAllProductsTable tbody");
            tableBody.empty();
            var fullHTML = "";
            for(var i = 0; i < arr.length; i++){
                var rowData = arr[i];
                var productInfo = rowData["name"] + ' ' + rowData["volume"] + rowData["unit"];
                var rowID = rowData['id'];

                fullHTML += createBrandProductRow(productInfo, rowData['category']['name'], rowID);
            }
            tableBody.append(fullHTML);
        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function createBrandProductRow(productText, categoryName, id){
    var row = '<tr>' +
                '<td>'+productText+'</td>' +
                '<td>'+categoryName+'</td>' +
                '<td><i data-product-id="'+id+'" class="fa fa-pencil point"></i></td>' +
                '<td><i data-product-id="'+id+'" class="fa fa-times shopRemoveRow"></i></td>';
    row += '</tr>';
    return row;
}
function getAllCategories() {
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
            $(createCategorySelect(null)).replaceAll('#category');
        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}

function addBrandProduct(storeProduct){
    var storeID = currentStore.id;
    var productID = storeProduct.store;
    var categoryID = storeProduct.category;
    var price = storeProduct.price;
    // /api/product/add_product_to_store/{storeId}/product/{productId}/store_category/{storeCategory}
    var url = '/api/product/add_product_to_store/'+storeID+'/product/'+productID+'/store_category/'+categoryID;

    $.post(url, price, function Success(data, textStatus){
        console.log(data);
        console.log(textStatus);
    });
}

function changeStoreProduct(){
    var url = '/api/product/remove_product_from_store/{storeId}/product/{productId}/category/{categoryId}';
}

