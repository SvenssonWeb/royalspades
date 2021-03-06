<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
	Inst�llningar
</h2>

<fieldset class="accountSettings">
	<legend>Kontoinst�llningar</legend>
	<form name="account" id="account" method="POST">
		<table class="formtable">
			<tr>
				<td>
					<label for="firstName">F�rnamn: </label>
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
					<label for="username">Anv�ndarnamn: </label>
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
<fieldset class="passwordSettings">
	<legend>�ndra L�senord</legend>
	<form name="passwordForm" id="passwordForm">
		<table class="formtable">
			<tr>
				<td>
					<label for="oldPassword">Ditt nuvarande l�senord: </label>
				</td>
				<td>
					<input type="password" id="oldPassword" name="oldPassword">
				</td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<label for="password">Nytt l�senord: </label>
				</td>
				<td>
					<input type="password" id="password" name="password">
				</td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<label for="passwordConfirm">Bekr�fta nytt l�senord: </label>
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
<br />
<br />
<fieldset class="mobileAuthority">
	<legend>Tappat din telefon? Sp�rra den h�r.</legend>
	<form name="mobileForm" id="mobileForm">
		<input type="Submit" value="Sp�rra">	
	</form>
</fieldset>
<br />
<div id="mobileResponse" class="response"></div>
<div id="mobileError" class="error"></div>


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
        			
       				if(response.responseText.indexOf('{"field"') > -1) {
         				responseJSON = JSON.parse(response.responseText);
       				}
        			        			
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
        			var responseJSON = response.responseJSON;  // not working here
        			
       				if(response.responseText.indexOf('{"field"') > -1) {
         				responseJSON = JSON.parse(response.responseText);
       				}
        			        			
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
	
	// Un-authorize mobile clients
	$('#mobileForm').submit(function(e) {
		  $("#mobileResponse").text("");
	  	  $('#mobileError').text("");

    	  // will pass the form data and parse it to json string
    	  $.ajax({
    		  url:baseUrl+'/api/user/unauthoriz_mobile/' + userId,
    		  data: '',
    		  contentType:'application/json',
    		  accept:'application/json',
    		  processData:false,
    		  type: 'PUT',
    		  complete: function(response) {
  				if(response.status == 200){
  		    	    $('#mobileResponse').text(response.responseText);
  				}
				
    		  }, error: function(response){
    			if(response.status != 200){
            		$('#mobileError').text(response.responseText); 
    			}
    	  	   	
    		  }
    	  });
	   
	  e.preventDefault(); // prevent actual form submit and page reload
	});
	
  });

</script>