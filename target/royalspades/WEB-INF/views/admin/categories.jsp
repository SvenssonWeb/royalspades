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
	<input type="text" type="text" name="name" placeholder = "Skriv in din nya varukategori." >
	<button submit="" id="toggleCatBtn">Spara</button>
</form>
	<button id="addCatBtn">L‰gg till ny kategori</button><br>
	<form id="editCatForm" style="display: none">
	<input type="text" type="text" name="name" placeholder = "Skriv in din nya varukategori." >
	<button submit="" id="toggleeditCatBtn">Spara</button>
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
	$(document).on("click","#addCatBtn",function(){
		$("#newCatForm").show();
		$("#addCatBtn").hide();
	});

	$(document).on("click","#toggleCatBtn",function(event){
		$("#newCatForm").hide();
		
		$("#addCatBtn").show();
	});
	

    // Save category AJAX Form Submit
    $('#newCatForm').submit(function(e) {
       e.preventDefault(); // prevent actual form submit and page reload

  	  $("#response").text("");
  	  
      // will pass the form data using the jQuery serialize function
      $.post(baseUrl+'/api/category/admin/add_category', $(this).serialize(), function(response) {
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
	
	//kunna posta datan i formul√§ret f√∂r att skapa ny cat, kunna markera nya poster och ta bort eller ÔøΩndra
	
	$("#addCatBtn").on("click", function(){
		//$("newCatForm").show();
	});
	
	var d = new Date();
	$("input[name$='date']").val(d.getFullYear() + "-" + preZero(d.getMonth()+1) + "-" + preZero(d.getDate()) + " " + preZero(d.getHours()) + ":" + preZero(d.getMinutes())).prop('disabled', true);
	
	function getCategory (id){
		//Diven tˆms pÂ information och sedan laddas om
			//$("#categoryTableDiv").html("<table id=\"categoryTable\" class=\"listtable\"><tr><th>Kategorier</th><th>&nbsp;</th></tr></table>");
		
		//H√§mtar all data fr√•n kategorier i db:n
		$.ajax({
			type: "GET",
			url: "/royalspades/api/category/"+id,
			dataType: "text",
			success: function (data, textStatus, jqXHR) {
				var arr = JSON.parse(data);
				//startar en tbody-tag
				//loopar igenom all data och l√§gger i en tabell
				for(var i = 0; i < arr.length; i++){
					var row = arr[i].name;
				}
				
			},
			error: function (data, textStatus, jqXHR) {
				alert("Error: " + textStatus + ", " + jqXHR);
			}
		});
	}
	
	function deleteCategory(event, id){
		  event.preventDefault();
		  
		  if (confirm(' ƒr du s‰ker pÂ att du vill ta bort kategorin?')) {
		   
		   $.post('/royalspades/api/admin/remove_category/' + id, null, function(response) {
		      console.log(response);
		        });
		  	}
		 }
	
});
function refreshTable (){
//Diven tˆms pÂ information och sedan laddas om
	

//H‰mtar all data frÂn kategorier i db:n
	$.ajax({
		type: "GET",
		url: "/royalspades/api/category/all/",
		dataType: "text",
		success: function (data, textStatus, jqXHR) {
			var arr = JSON.parse(data);
			//startar en tbody-tag
			
			$("#categoryTable tbody").empty();
			//loopar igenom all data och l‰gger i en tabell
			for(var i = 0; i < arr.length; i++){
				var row = "<tr><td>";
				row += arr[i].name;
				row += '</td><td style="text-align:center;">';
				row += '<a class="link black" href="" onclick="editCategory(event, ' + arr[i].id + ')"><i class="fa fa-pencil black"></i></a>';
				row += '</td><td style="text-align:center;">';
				row += '<a class="link red" href="" onclick="deleteCategory(event, ' + arr[i].id + ')"><i class="fa fa-times red"></i></a>';	
				row += "</td></tr>";
				
				$("#categoryTable tbody").append(row);
			}
		},
		error: function (data, textStatus, jqXHR) {
			alert("Error: " + textStatus + ", " + jqXHR);
		}
	});
	
	
} 
</script>