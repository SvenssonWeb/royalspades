<script>
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
					<label for="lastName">Eftername: </label>
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
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<label for="oldPassword">Nuvarande lösenord: </label>
				</td>
				<td>
					<input type="password" id="oldPassword" name="oldPassword">
				</td>
			</tr>
			<tr>
				<td>
					<label for="password">Nytt lösenord: </label>
				</td>
				<td>
					<input type="password" id="password" name="password">
				</td>
			</tr>
			<tr>
				<td>
					<label for="passwordConfirm">Upprepa nytt lösenord: </label>
				</td>
				<td>
					<input type="password" id="passwordConfirm" name="passwordConfirm">
				</td>
			</tr>
			<tr><td>&nbsp;</td><td></td></tr>
			<tr>
				<td>
					<input type="Submit" value="Spara">
				</td>
				<td>
				</td>
			</tr>
		</table>
	</form>
</fieldset>
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
	
	function getValues(){
		$.getJSON("/royalspades/api/user/${username}")
			.done(function(data) {
				$("input[name='firstName']").val(data.firstName);
				$("input[name='lastName']").val(data.lastName);
				$("input[name='username']").val(data.username);
				$("input[name='email']").val(data.email);	
			})
			.fail(function(jqxhr, textStatus, error) {
			    var err = textStatus + ", " + error;
		        $('.error').text("Något gick fel: " + err);
			});
	}
	

	// get all values 
	getValues();
	
	// Edit Account
	$('#account').submit(function(e) {
		  $(".response").text("");
	  	  $('.error').text("");

    	  var data = $(this).serializeObject();
    	  // will pass the form data and parse it to json string
    	  $.ajax({
    		  url:'/royalspades/api/user/edit_account',
    		  data: JSON.stringify(data),
    		  contentType:'application/json',
    		  accept:'application/json',
    		  processData:false,
    		  type: 'PUT',
    		  complete: function(response) {
  				if(response.status == 200){
  	    			// clear values
  				    $(':input','#editSupplierForm')
  						.not(':button, :submit, :reset, :hidden')
  						.val('');
  		    	    $('.response').text(response.responseText);
  		    	    
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
            	  	  	
            	  	   	$('.error').append(errors);

        	  	   	} else {
            	  	   	$('.error').text(response.responseText); 
        	  	   	}
    			}
    	  	   	
    		  }
    	  });
	   
	  e.preventDefault(); // prevent actual form submit and page reload
	});
  });
</script>