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
                <tbody>
                    <tr>
                        <td>
                            Ica
                        </td>
                        <td>
                            500
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Coop
                        </td>
                        <td>
                            551
                        </td>
                    </tr>
                    <tr>
                        <td>
                            City Gross
                        </td>
                        <td>
                            400
                        </td>
                    </tr>
                </tbody>
            </table>

        </tr>
        <tr>
            <td>
                <input id="compare" type="Submit" value="J&auml;mf&ouml;r">
            </td>
        </tr>
    </table>

</form>

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
                $('#accountError').text("N�got gick fel: " + err);
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

    $.getJSON(baseUrl+"/api/grocerylist/prices/" + groceryListId)
            .done(function(data){
                console.log(data);
            })
}

</script>
