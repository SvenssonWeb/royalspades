<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
Ny matkasse
</h2>
<br />
<table>
	<tr>
		<td>
			<label for="groceryName">Namn:</label>
		</td>
		<td>
			<input id="groceryName"  name="name" type="text" />
			<input id="userId"  name="userId" type="hidden" />
		</td>
	</tr>
	<tr>
		<td>
			<label for="groceryDate">Skapad:</label>
		</td>
		<td>
			<input id="groceryDate" name="date" type="text" />
		</td>
	</tr>
</table>
<br />

<table id="dataTable" class="groceryTable listtable">
	<thead>
		<tr>
			<th>
				Varunamn
			</th>
			<th>
				Mängd
			</th>
			<th>
				Mått
			</th>
			<th>
				Leverantör
			</th>
			<th>
				Kategori
			</th>
			<th>
				Antal
			</th>
			<th>
				Lägg till
			</th>
		</tr>	
	</thead>
</table>
<input type="submit" id="save" value="Skapa matkasse">
<br />
<br />
<div class="error"></div>
<div class="response"></div>
<script>
$( document ).ready(function() {	
	var timesToGo = 0;
	var volumes = [];
	var productIds = [];
	
	function preZero(s){
		s += "";
		if(s.length < 2){
			s = "0" + s;
		}
		return s;
	}
	var d = new Date();
	$("input[name$='date']").val(d.getFullYear() + "-" + preZero(d.getMonth()+1) + "-" + preZero(d.getDate()) + " " + preZero(d.getHours()) + ":" + preZero(d.getMinutes())).prop('disabled', true);
	

	$.getJSON(baseUrl+"/api/user/${username}")
		.done(function(data) {
			$($("input[name='userId']")).val(data.id);	
		})
		.fail(function(jqxhr, textStatus, error) {
		    var err = textStatus + ", " + error;
	        $('#accountError').text("Något gick fel: " + err);
		});
	
	
	$.ajax({
		type: "GET",
		url: baseUrl+"/api/product/all/",
		dataType: "text",
		success: function (data, textStatus, jqXHR) {
		var arr = JSON.parse(data);
		
		$(".groceryTable").append("<tbody>");
		for(var i = 0; i < arr.length; i++){
			var row = "<tr><td>";
			row += '<input type="hidden" class="productId" id="' + arr[i].id + '">';
			row += arr[i].name;
			row += '</td><td style="text-align:right;">';
			row += arr[i].volume;
			row += "</td><td>";
			row += arr[i].unit;
			row += "</td><td>";
			
			if($.isNumeric(arr[i].brand)){
				for(var j = 0; j < arr.length; j++){
					if(arr[j].brand['@id'] == arr[i].brand){
						arr[i].brand = arr[j].brand;
						row += arr[i].brand.name;
					}
				}
			} else {
				row += arr[i].brand.name;
			}
			row += "</td><td>";
			if($.isNumeric(arr[i].category)){
				for(var j = 0; j < arr.length; j++){
					if(arr[j].category['@id'] == arr[i].category){
						arr[i].category = arr[j].category;
						row += arr[i].category.name;
					}
				}
			} else {
				row += arr[i].category.name;
			}
			row += '<td style="text-align:center;"><select class="quantity"><option val="-">Välj</option></select></td>';
			row += '</td><td style="text-align:center;">';
			row += '<input type="checkbox">';
			row += "</td></tr>";
			$(".groceryTable").append(row);	
		}	
		
		for(var i = 1; i < 11; i++){
	        $(".quantity").append( // Append an object to the inside of the select box
		            $("<option></option>")
		                .text(i)
		                .val(i)
		        );
		}
		
		
	    $(".quantity").val("-");
		
		$(".groceryTable").append("</tbody>");
		
		$('.groceryTable').dataTable({
		"aLengthMenu": [
            [25, 50, 100, -1],
            [25, 50, 100, "All"]],
		"iDisplayLength" : -1,
        "bScrollInfinite": true,
        "bScrollCollapse": false,
        "sScrollY": "300px",
		"oLanguage": {
			"sLengthMenu": "Visar _MENU_ produkter per sida",
			"sZeroRecords": "Hittade inget - tyvärr",
			"sInfo": "Visar _START_ till _END_ av _TOTAL_ varor",
			"sInfoEmpty": "Visar 0 av 0 varor",
			"sInfoFiltered": "(filtrerat från _MAX_ varor)",
			"sSearch": "Filtrera: "
		}		
		});
		},
		error: function (data, textStatus, jqXHR) {
			$('.error').text("Error: " + textStatus + ", " + jqXHR);
		}
	});
	
	// add each product to the list
	function addProductToBag(productId, volume, listId){
  	  // will pass the form data and parse it to json string
  	  $.ajax({
  		  url:baseUrl+'/api/grocerylist/add_product_to_grocery_list/' + listId + '/product/' + productId,
  		  data: volume,
  		  contentType:'application/json',
  		  accept:'application/json',
  		  processData:false,
  		  type: 'PUT',
  		  complete: function(response) {
				if(response.status == 200){
								
					if(timesToGo > 1){
						// reduce timesToGo and remove from array
						timesToGo--;
						productIds.splice(0,1);
						volumes.splice(0,1);
						
						// run ajax method again
						addProductToBag(productIds[0], volumes[0], listId);
					} else {
			   			// clear values
	  				    $(':input')
	  						.not(':button, :submit, :reset, :hidden')
	  						.val('')
	  						.removeAttr('checked');
	  		    	    $('.response').text("Handlarlistan skapad!");
					}
					
				}
				
  		  }, error: function(response){
  			if(response.status != 200){
      			var responseJSON = response.responseJSON;
      			
      	  	   	if(typeof responseJSON != 'undefined'){
      	  	   		var errors = '';
      	  	   		
          	  	   	for(var i = 0; i < responseJSON.fieldErrors.length; i ++){
              	  	   	errors += (responseJSON.fieldErrors[i].message); 
              	  	   	errors += '<br>';
          	  	   	}
          	  	  	
          	  	   	$('.error').append(errors);

      	  	   	} else {
          	  	   	$('.error').text(response.responseText); 
      	  	   	}
  			}
  	  	   	
  		  }
  	  });
	}
	
	 
	
	// run for every product
	function addProductsToBags(listId){
		// get all selected values from checked checkboxes
		$('#dataTable > tbody > tr').filter(':has(:checkbox:checked)').each(function() {
		   
			// add to the number of times we need to run this
			timesToGo++;
			volumes.push(($(this).find("option:selected").val()));
			productIds.push(($(this).find("input").attr('id')));
			
			//validate volume here
		});
		
		
		// add each product to list
		addProductToBag(productIds[0], volumes[0], listId);
	}
	
	
	function createGroceryBag(userId, name){
    	  $.ajax({
    		  url:baseUrl+'/api/grocerylist/add_grocery_list/' + userId,
    		  data: '{"name":"' + name + '"}',
    		  contentType:'application/json',
    		  accept:'application/json',
    		  processData:false,
    		  type: 'POST',
    		  complete: function(response) {
  				if(response.status == 200){
  					// if the list was created then add products
  					$('.response').text("Lägger till...");
  					addProductsToBags(response.responseText);
  				}
				
    		  }, error: function(response){
    			if(response.status != 200){
        			var responseJSON = response.responseJSON;
        			
        	  	   	if(typeof responseJSON != 'undefined'){
        	  	   		var errors = '';
        	  	   		
            	  	   	for(var i = 0; i < responseJSON.fieldErrors.length; i ++){
                	  	   	errors += (responseJSON.fieldErrors[i].message); 
                	  	   	errors += '<br>';
            	  	   	}
            	  	  	
            	  	   	$('.error').append(errors);

        	  	   	} else {
            	  	   	$('.error').text(response.responseText); 
        	  	   	}
    			}
    	  	   	
    		  }
    	  });
	}
	
	
	// Save grocery bag
	$('#save').click(function() {
		$(".response").text("");
	  	$('.error').text("");

	  	var groceryBagName = ($('#groceryName').val());
		var userId = ($('#userId').val());
		
		// VALIDATE NAME
		
		// create the grocery bag
		createGroceryBag(userId, groceryBagName);
	});
	
	
});
</script>