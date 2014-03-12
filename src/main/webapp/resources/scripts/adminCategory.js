/**
 * Created by Artwar on 2014-02-26.
 */
$.ajaxSetup({
    Accept:"application/json",
    contentType: "application/json; charset=utf-8",
    dataType:'text'
});

$(document).on('click', '#categoryTable .fa-times', function(){
    var categoryId = $(this).data().categoryId;
    deleteCategory(categoryId)
});
$(document).on("click","#addCatBtn",function(){
    $("#newCatForm").show();
    $("#addCatBtn").hide();
});

$(document).on("click","#toggleCatBtn",function(event){
    $("#newCatForm").hide();

    $("#addCatBtn").show();
});
function refreshTable (){
    $.ajax({
        type: "GET",
        url: baseUrl+"/api/category/all/",
        dataType: "text",
        success: function (data) {
            var arr = parseJSON(data);

            var element = $("#categoryTable").find("tbody");
            element.empty();
            var html = '';
            for(var i = 0; i < arr.length; i++){
                var row = "<tr id=\"" + arr[i].id + "\"><td>";
                row += arr[i].name;
                row += '</td><td style="text-align:center;">';
                row += '<a class="link black" href="editCategory/?id=' + arr[i].id + '"><i class="fa fa-pencil black"></i></a>';
                row += '</td><td style="text-align:center;">';
                row += '<i data-category-id="'+arr[i].id+'" class="fa fa-times red"></i>';
                row += "</td></tr>";

                html += row;
            }
            element.append(html);
        },
        error: function (data, textStatus, jqXHR) {
            alert("Error: " + textStatus + ", " + jqXHR);
        }
    });
}
function deleteCategory(id){
    if (confirm(' Är du säker på att du vill ta bort kategorin?')) {

        $.ajax({
            url:baseUrl+'/api/category/admin/remove_category/' + id,
            type:'DELETE',
            complete: function(response) {

                if(response.status == 200) {
                    $('#' + id).remove();
                } else {
                    alert(response.responseText);
                    //$('.error').text(response.responseText);
                }
            },
            error: function (response, data, textStatus, jqXHR) {
                if(response.status != 200){
                    //$('.error').text("Error: " + textStatus + ", " + jqXHR);
                }
            }
        });
    }
}
function updateCategory(data){
    console.log(JSON.stringify(data));
    if (confirm(' Är du säker på att du vill ändra kategorin?')) {

        $.ajax({
            url:baseUrl + '/api/category/admin/edit_category/',
            type:'PUT',
            data:JSON.stringify(data),
            complete: function(response) {

                if(response.status == 200) {
					history.go(-1);
                } else {
                    alert(response.responseText);
                    //$('.error').text(response.responseText);
                }
            },
            error: function (response, data, textStatus, jqXHR) {
                if(response.status != 200){
                    //$('.error').text("Error: " + textStatus + ", " + jqXHR);
                }
            }
        });
    }
}