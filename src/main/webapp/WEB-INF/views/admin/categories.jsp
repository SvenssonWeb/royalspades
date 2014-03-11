<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2> 
	Varor
</h2>
<div id="categoryTableDiv">
	<table id="categoryTable" class="listtable">
		<thead>
			<tr>
				<th>Kategorier</th><th>&nbsp;</th><th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>
<form id="newCatForm" style="display: none">
	<input type="text" name="name" placeholder = "Skriv in din nya varukategori." >
	<button id="toggleCatBtn">Spara</button>
</form>
<button id="addCatBtn">Lägg till ny kategori</button><br>

<form id="editCatForm" style="display: none">
	<input type="text" name="name" placeholder = "Skriv in din nya varukategori." >
	<button id="toggleeditCatBtn">Spara</button>
</form>
	
<script>


$( document ).ready(function() {	
	refreshTable();
	function preZero(s){
		s += "";
		if(s.length < 2){
			s = "0" + s;
		}
		return s;
	}

	

    // Save category AJAX Form Submit
    $('#newCatForm').submit(function(e) {
       e.preventDefault(); // prevent actual form submit and page reload

  	  $("#response").text("");
  	  
      // will pass the form data using the jQuery serialize function
      $.post(baseUrl+'/api/category/admin/add_category', JSON.stringify($(this).serializeObject()), function(response) {
		  console.log(response);
        // clear values
        $(':input','#newCatForm')
			.not(':button, :submit, :reset, :hidden')
			.val('')
			.removeAttr('selected');
      		refreshTable();
        $('#response').text(response);
      });
       
    });
	
	//kunna posta datan i formuläret för att skapa ny cat, kunna markera nya poster och ta bort eller ändra
	
	$("#addCatBtn").on("click", function(){
		//$("newCatForm").show();
	});
	
	var d = new Date();
	$("input[name$='date']").val(d.getFullYear() + "-" + preZero(d.getMonth()+1) + "-" + preZero(d.getDate()) + " " + preZero(d.getHours()) + ":" + preZero(d.getMinutes())).prop('disabled', true);
	

});

</script>