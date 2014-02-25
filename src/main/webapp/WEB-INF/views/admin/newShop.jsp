<script>
	window.location.hash = "p=" + '${pageUid}';
</script>
<h2> 
	Ny butik
</h2>
<br />
<div id="error"></div>

<form id="newShopForm">
	<table>
		<tr>
			<td>
				<label for="name">Namn på butik: </label>
			</td>
			<td>
				<input name="name" id="name"><br />
			</td>
		</tr>
		<tr>
			<td>
				<label for="address">Address: </label>
			</td>
			<td>
				<input name="address" id="address"><br />
			</td>
		</tr>
		<tr>
			<td>
				<label for="postalCode">Postnummer: </label>
			</td>
			<td>
				<input name="postalCode" id="postalCode"><br />
			</td>
		</tr>
		<tr>
			<td>
				<label for="city">Stad: </label>
			</td>
			<td>
				<input name="city" id="city"><br />
			</td>
		</tr>
		<tr>
			<td>
				<label for="orgNumber">Org.nr: </label>
			</td>
			<td>
				<input name="orgNumber" id="orgNumber"><br />
			</td>
		</tr>
		<tr>
			<td>
				<label for="phone">Telefonnummer: </label>
			</td>
			<td>
				<input name="phone" id="phone"><br />
			</td>
		</tr>
		<tr>
			<td>
				<label for="user">Administratör: </label>
			</td>
			<td>
				<select id="user"></select>
			</td>
		</tr>
	</table>
    <input type="submit" value="Lägg till">
</form>
<br />
<div class="response"></div>
<div class="error"></div>

<script>
$(document).ready(function() {
	
	$.fn.serializeObject = function()
	{
	   var o = {};
	   var a = this.serializeArray();
	   
	   $.each(a, function() {
	       if (o[this.name]) {
	           if (!o[this.name].push) {
	               o[this.name] = [o[this.name]];
	           }
	           o[this.name].push(this.value || '');
	       } else {
	           o[this.name] = this.value || '';
	       }
	   });
	   return o;
	};
	
	// fill the select box with users that can be a shop administrator
	$.getJSON("/royalspades/api/admin/user/shop_managers/")
	    .done(function(data) {
		    $("#user option").remove(); // Remove all <option> child tags.
		    $("#user").append( $("<option></option>") .text("Välj"));  
		    $.each(data, function(index, item) { // Iterates through a collection
		        $("#user").append( // Append an object to the inside of the select box
		            $("<option></option>")
		                .text(item.firstName + " " + item.lastName)
		                .val(item.id)
		        );
		    });
		})
		.fail(function(jqxhr, textStatus, error) {
		    var err = textStatus + ", " + error;
	        $('.error').text("Något gick fel: " + err);
		});
	
	
	// Save shop AJAX form
	$('#newShopForm').submit(function(e) {
		  $(".response").text("");
	  	  $('.error').text("");
	  	  // get userId from selected option
	  	  var userId = $("#user option:selected").val();
	  	  
	  	  if(userId != 'Välj'){
	    	  var data = $(this).serializeObject();
	    	  // will pass the form data and parse it to json string
	    	  $.ajax({
	    		  url:'/royalspades/api/store/admin/add_store/' + userId,
	    		  data: JSON.stringify(data),
	    		  contentType:'application/json',
	    		  accept:'application/json',
	    		  processData:false,
	    		  type: 'POST',
	    		  complete: function(response) {
	  				if(response.status == 200){
	  	    			// clear values
	  				    $(':input','#newShopForm')
	  						.not(':button, :submit, :reset, :hidden')
	  						.val('');
	  		    	    $('.response').text(response.responseText);
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
	  	  } else {
	  		  $('.error').text('Du måste välja en administratör!');
	  	  }

	   
	  e.preventDefault(); // prevent actual form submit and page reload
	});
  });
</script>