﻿<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
	Inställningar
</h2>

<fieldset class="accountSettings">
	<legend>Kontoinställningar</legend>
	<form name="account" id="account" method="POST">
		<table class="formtable">
			<tr>
				<td>
					<label for="firstName">Förnamn: </label>
				</td>
				<td>
					<input type="text" id="firstName" name="firstName">
				</td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<label for="lastName">Efternamn: </label>
				</td>
				<td>
					<input type="text" id="lastName" name="lastName">
				</td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<label for="username">Användarnamn: </label>
				</td>
				<td>
					<input type="text" id="username" name="username">
				</td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<label for="email">Mailadress: </label>
				</td>
				<td>
					<input type="text" id="email" name="email">
				</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" id="id" name="id">
			   </td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<input type="Submit" value="Spara">
				</td>
			</tr>
		</table>
	</form>
</fieldset>
<br />
<div id="accountResponse" class="response"></div>
<div id="accountError" class="error"></div>
<br />
<br />
<fieldset class="authoritySettings">
	<legend>Ansök om högre behörighet</legend>
	<form name="authorityForm" id="authorityForm">
		<select id="authority">
			<option value="0">Välj</option> 
			<option value="shopowner">Butiksägare</option>
			<option value="producer">Leverantör</option>
			<option value="admin">Administratör</option>
		</select>
		<input type="Submit" value="Ansök">
		
	</form>
</fieldset>
<br />
<div id="authorityResponse" class="response"></div>
<div id="authorityError" class="error"></div>
<br />
<br />
<fieldset class="passwordSettings">
	<legend>Ändra Lösenord</legend>
	<form name="passwordForm" id="passwordForm">
		<table class="formtable">
			<tr>
				<td>
					<label for="oldPassword">Ditt nuvarande lösenord: </label>
				</td>
				<td>
					<input type="password" id="oldPassword" name="oldPassword">
				</td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<label for="password">Nytt lösenord: </label>
				</td>
				<td>
					<input type="password" id="password" name="password">
				</td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<label for="passwordConfirm">Bekräfta nytt lösenord: </label>
				</td>
				<td>
					<input type="password" id="passwordConfirm" name="passwordConfirm">
				</td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<input type="hidden" id="id" name="id">
			   </td>
			</tr>
			<tr>
				<td>
					<input type="Submit" value="Spara">
				</td>
			</tr>
		</table>
	</form>
</fieldset>
<br />
<div id="passwordResponse" class="response"></div>
<div id="passwordError" class="error"></div>


<script>
$(document).ready(function() {
	var userId;
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
	
	function getValues(){
		$.getJSON(baseUrl+"/api/user/${username}")
			.done(function(data) {
				$($("input[name='id']")[0]).val(data.id);
				$($("input[name='id']")[1]).val(data.id);
				userId = data.id;
				$("input[name='firstName']").val(data.firstName);
				$("input[name='lastName']").val(data.lastName);
				$("input[name='username']").val(data.username);
				$("input[name='email']").val(data.email);	
			})
			.fail(function(jqxhr, textStatus, error) {
			    var err = textStatus + ", " + error;
		        $('#accountError').text("N�got gick fel: " + err);
			});
	}
	

	// get all values 
	getValues();
	
	// Edit Account
	$('#account').submit(function(e) {
		  $("#accountResponse").text("");
	  	  $('#accountError').text("");

    	  var data = $('#account').serializeObject();
    	  // will pass the form data and parse it to json string
    	  $.ajax({
    		  url:baseUrl+'/api/user/edit_account',
    		  data: JSON.stringify(data),
    		  contentType:'application/json',
    		  accept:'application/json',
    		  processData:false,
    		  type: 'PUT',
    		  complete: function(response) {
  				if(response.status == 200){
  	    			// clear values
  				    $(':input','#account')
  						.not(':button, :submit, :reset, :hidden')
  						.val('');
  		    	    $('#accountResponse').text(response.responseText);
  		    	    
  		    	    getValues();
  				}
				
    		  }, error: function(response){
    			if(response.status != 200){
       				var responseJSON = response.responseJSON;  // not working here
        			
     				responseJSON = JSON.parse(response.responseText);
        			
        	  	   	if(typeof responseJSON != 'undefined'){
        	  	   		var errors = '';
        	  	   		
            	  	   	for(var i = 0; i < responseJSON.fieldErrors.length; i ++){
                	  	   	errors += (responseJSON.fieldErrors[i].message); 
                	  	   	errors += '<br>';
            	  	   	}
            	  	  	
            	  	   	$('#accountError').append(errors);

        	  	   	} else {
            	  	   	$('#accountError').text(response.responseText); 
        	  	   	}
    			}
    	  	   	
    		  }
    	  });
	   
	  e.preventDefault(); // prevent actual form submit and page reload
	});
	
	// Edit Password
	$('#passwordForm').submit(function(e) {
		  $("#passwordResponse").text("");
	  	  $('#passwordError').text("");

    	  var data = $('#passwordForm').serializeObject();
    	  // will pass the form data and parse it to json string
    	  $.ajax({
    		  url:baseUrl+'/api/user/edit_password',
    		  data: JSON.stringify(data),
    		  contentType:'application/json',
    		  accept:'application/json',
    		  processData:false,
    		  type: 'PUT',
    		  complete: function(response) {
  				if(response.status == 200){
  	    			// clear values
  				    $(':input','#passwordForm')
  						.not(':button, :submit, :reset, :hidden')
  						.val('');
  		    	    $('#passwordResponse').text(response.responseText);
  		    	    
  		    	    getValues();
  				}
				
    		  }, error: function(response){
    			if(response.status != 200){
     				var responseJSON = response.responseJSON; // not working here
     				
     				responseJSON = JSON.parse(response.responseText);

     				if(typeof responseJSON != 'undefined'){
        	  	   		var errors = '';
        	  	   		
            	  	   	for(var i = 0; i < responseJSON.fieldErrors.length; i++){
                	  	   	errors += (responseJSON.fieldErrors[i].message); 
                	  	   	errors += '<br>';
            	  	   	}
            	  	  	
            	  	   	$('#passwordError').append(errors);

        	  	   	} else {
            	  	   	$('#passwordError').text(response.responseText); 
        	  	   	}
    			}
    	  	   	
    		  }
    	  });
	   
	  e.preventDefault(); // prevent actual form submit and page reload
	});
	
	// Request Higher authority
	$('#authorityForm').submit(function(e) {
		  $("#authorityResponse").text("");
	  	  $('#authorityError').text("");

	  	  var data = $("#authority").find("option:selected").val();
	  	  
	  	  if(data != '0'){
	    	  // will pass the form data and parse it to json string
	    	  $.ajax({
	    		  url:baseUrl+'/api/user/'+ userId +'/request_authority',
	    		  data: data,
	    		  contentType:'application/json',
	    		  accept:'application/json',
	    		  processData:false,
	    		  type: 'PUT',
	    		  complete: function(response) {
	  				if(response.status == 200){
	  	    			// clear values
	  				    $(':input','#authorityForm')
	  						.not(':button, :submit, :reset, :hidden')
	  						.val('');
	  		    	    $('#authorityResponse').text(response.responseText);
	  		    	    
	  		    	    getValues();
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
	            	  	  	
	            	  	   	$('#authorityError').append(errors);

	        	  	   	} else {
	            	  	   	$('#authorityError').text(response.responseText); 
	        	  	   	}
	    			}
	    	  	   	
	    		  }
	    	  });
	  	  } else {
  	  	   	$('#authorityError').text("Du måste välja en behörighetsgrad för att kunna ansöka"); 
	  	  }

	   
	  e.preventDefault(); // prevent actual form submit and page reload
	});
	
  });

</script>