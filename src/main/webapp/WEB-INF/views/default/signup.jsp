		<div id="register" class="animate form">
            <form id="signup" autocomplete="on" method="POST"> 
                <h1> Skapa konto </h1> 
				<table>
					<tr>
						<td>
							<label for="firstName" data-icon="u">Förnamn</label>
						</td><td>
							<input id="firstName" name="firstName" required="required" type="text"  maxlength="45" placeholder="Olle" />
						</td>
					</tr>

					<tr>
						<td>
							<label for="lastName" data-icon="u">Efternamn</label>
						</td><td>
							<input id="lastName" name="lastName" required="required" type="text" maxlength="45" placeholder="Andersson" />
						</td>
					</tr>

					<tr>
						<td>
							<label for="username" data-icon="u">Anv&auml;ndarnamn</label>
						</td><td>
							<input id="username" name="username" required="required" type="text" maxlength="45" placeholder="mysuperusername690" />
						</td>
					</tr>

					<tr>
						<td>
							<label for="email" data-icon="e" > Email</label>
						</td><td>
							<input id="email" name="email" required="required" type="email" maxlength="45" placeholder="mysupermail@mail.com"/>
						</td>
					</tr>

					<tr>
						<td>
							<label for="password" data-icon="p">L&ouml;senord * </label>
						</td><td>
							<input id="password" name="password" required="required" type="password" maxlength="45" placeholder="eg. X8df!90EO"/>
						</td>
					</tr>

					<tr>
						<td>
							<label for="passwordConfirm" data-icon="p">Bekr&auml;fta l&ouml;senord * </label>
						</td><td>
							<input id="passwordConfirm" name="passwordConfirm" required="required" maxlength="45" type="password" placeholder="eg. X8df!90EO"/>
						</td>
					</tr>
					
					<tr>
						<td>
							<input type="submit" value="Skapa konto" id="signUpButton">
						</td><td>
							&nbsp;
						</td>
					</tr>
				</table>
            </form>
            <br />
            <div class="response"></div>
            <div class="error"></div>
        </div>
        
<script>
$(document).ready(function() {
	$.fn.serializeObject = function()
	{
	   var o = {};
	   var a = this.serializeArray();
	   a.re
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
	
	// AJAX Signup Form Submit
	$('#signup').submit(function(e) {
		  $(".response").text("");
	  	  $('.error').text("");
    	  var data = $(this).serializeObject();
    	  // will pass the form data and parse it to json string
    	  $.ajax({
    		  url:'/royalspades/api/admin/user/new_user',
    		  data: JSON.stringify(data),
    		  contentType:'application/json',
    		  accept:'application/json',
    		  processData:false,
    		  type: 'POST',
    		  complete: function(response) {
  				if(response.status == 200){
  	    			// clear values
  				    $(':input','#signup')
  						.not(':button, :submit, :reset, :hidden')
  						.val('');
  		    	    $('#signUpButton').prop('disabled', true);
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
	   
	  e.preventDefault(); // prevent actual form submit and page reload
	});
 
});
</script>