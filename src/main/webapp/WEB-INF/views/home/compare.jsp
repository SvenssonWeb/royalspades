<script>
    window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
    J&auml;mf&ouml;r
</h2>
<form  id="compareForm" action="">
    <table>
        <tr>
            <td>
                <label>V&auml;lj en matkasse</label>
            </td>
        </tr>
        <tr>
            <td>
                <select name="Matkassar" id="kassar">

                </select>
            </td>
        </tr>
        <tr>
            <td>
                <input id="compare" type="Submit" value="J&auml;mf&ouml;r">
            </td>
        </tr>
    </table>

</form>
            <table id="dataTable" class="priceTable listtable">
                <thead>
                <tr>
                    <th>
                        Butik
                    </th>
                    <th>
                        Pris
                    </th>
                </tr>
                </thead>
            </table>

<script>



var userId;
$(document).ready(function(){


    $('#compareForm').submit(function(e) {
        compare();
        e.preventDefault(); // prevent actual form submit and page reload
    });


    $.getJSON(baseUrl+"/api/user/${username}")
            .done(function(data){
                user = data;
                userId = (data.id);
                dropdown();
            })
            .fail(function(jqxhr, textStatus, error) {
                var err = textStatus + ", " + error;
                $('#accountError').text("Något gick fel: " + err);
            });

});
function dropdown(){
    $.getJSON(baseUrl+"/api/grocerylist/user/" + userId)
            .done(function(data) {
                $("#kassar").find("option").remove(); // Remove all <option> child tags.
                $("#kassar").empty();
                $.each(data, function(index, item) { // Iterates through a collection
                    $("#kassar").append( // Append an object to the inside of the select box
                            $("<option></option>")
                                    .text(item.name)
                                    .val(item.id)
                    );
                });
                $("#kasse").val(userId);
            })
            .fail(function(jqxhr, textStatus, error) {
                var err = textStatus + ", " + error;
                console.log("gffdjktdfcjyddc");
                $('.error').text("Något gick fel: " + err);
            });
}


function compare (){
    var groceryListId = $("option:selected").val();
    
    $('.priceTable tbody').remove();
    
    $.getJSON(baseUrl+"/api/grocerylist/prices/" + groceryListId)
            .done(function(data){
            	
            	$(".priceTable").append("<tbody>");
    			for(var i = 0; i < data.length; i++){
    				var row = "<tr id=" + data[i].storeId + ">" + "<td>";
    				row += data[i].storeName;
    				row += "</td><td>";
    				row += data[i].price + ' kr';
    				row += "</td></tr>";
    				$(".priceTable").append(row);
    			}
    			
    		    $(".priceTable").append("</tbody>");
            	
            });
}

</script>
