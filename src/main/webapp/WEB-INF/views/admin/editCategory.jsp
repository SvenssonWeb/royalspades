<script>
    window.location.hash = "p=" + '${pageUid}';
</script>
<h2>
    �ndra varukategori
</h2>

<form id="editCategoryForm">
    <input hidden="hidden" name="id">
    <table>
        <tr>
            <td>
                <label for="name">Namn: </label>
            </td>
            <td>
                <input name="name" id="name"><br/>
            </td>
        </tr>
    </table>
    <input type="submit" value="Spara">
</form>
<br/>

<div id="response"></div>

<script>
    $(document).ready(function () {
        var category;
        //Fill with previous values
        $.getJSON(baseUrl + "/api/category/" + "${id}")
                .done(function (data) {
                    category = data;
                    console.log(category);
                    $("input[name='name']").val(data.name);
                    $("input[name='id']").val(data.id);
                })
                .fail(function (jqxhr, textStatus, error) {
                    var err = textStatus + ", " + error;
                    $('#error').text("Något gick fel: " + err);
                });


        // Save Shop AJAX Form Submit
        $('#editCategoryForm').submit(function (e) {
            e.preventDefault();
            updateCategory($(this).serializeObject());
            /*
            $("#response").text("");
            // get userId from selected option
            var catId = $("#user").find("option:selected").val();

            // will pass the form data using the jQuery serialize function
            $.ajax()
            $.post(baseUrl + '/api/category/admin/edit_category/', $(this).serialize(),
                    function (response) {

                // clear values
                $(':input', '#editCategoryForm')
                        .not(':button, :submit, :reset, :hidden')
                        .val('')
                        .removeAttr('selected');

                $('#response').text(response);
            });

            e.preventDefault(); // prevent actual form submit and page reload
            */
        });

    });
</script>