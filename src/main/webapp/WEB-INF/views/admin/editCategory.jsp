<script>
	window.location.hash = "p=" + '${pageUid}';
</script>
<h2> 
	Ändra varukategori
</h2>

<form id="editCategoryForm">
	<table>
		<tr>
			<td>
				<label for="name">Namn: </label>
			</td>
			<td>
				<input name="name" id="name"><br />
			</td>
		</tr>
	</table>
    <input type="submit" value="Spara">
</form>
<br />
<div id="response"></div>

<script>
$(document).ready(function() {
	//Fill with previous values
	$.getJSON("/royalspades/api/category/" + "${id}")
	.done(function(data) {
		$("input[name='name']").val(data.name);
	})
	.fail(function(jqxhr, textStatus, error) {
	    var err = textStatus + ", " + error;
        $('#error').text("Något gick fel: " + err);
	});


	
	
	// Save Shop AJAX Form Submit
	$('#editCategoryForm').submit(function(e) {
		  $("#response").text("");
		  
	  	  // get userId from selected option
	  	  var catId = $("#user option:selected").val();
		  
	  // will pass the form data using the jQuery serialize function
	  $.post('/royalspades/api/category/admin/edit_category/' + catId, $(this).serialize(), function(response) {
		  
	    // clear values
	    $(':input','#editCategoryForm')
			.not(':button, :submit, :reset, :hidden')
			.val('')
			.removeAttr('selected');
	  	
	    $('#response').text(response);
	  });
	   
	  e.preventDefault(); // prevent actual form submit and page reload
	});
 
});
</script>