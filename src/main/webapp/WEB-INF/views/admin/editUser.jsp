<fieldset class="passwordSettings">
	<legend>Ändra Lösenord för: <b><span class="username"></span></b></legend>
	<form name="passwordForm" id="passwordForm">
		<table class="formtable">
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
					<input type="Submit" value="Sï¿½tt nytt lï¿½senord">
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
<fieldset class="authoritySettings">
	<legend>Ändra behörighet för: <span class="username"></span></legend>
	<form name="authorityForm" id="authorityForm">
	    <div><b><span class="username"></span></b> Ansöker om behörighet: <b><span class="requestedAuthority"></span></b></div>
		<select id="authority">
			<option value="user">Användare</option>
			<option value="shopowner">Butiksägare</option>
			<option value="producer">Leverantör</option>
			<option value="admin">Administratör</option>
		</select>
		<input type="Submit" value="Ändra">
		
	</form>
</fieldset>
<br />
<div id="authorityResponse" class="response"></div>
<div id="authorityError" class="error"></div>
<br />
<br />





<script>

//grant higher authority
function grantAuthority(){
	$('#passwordResponse').text("");
	$('#passwordError').text("");
	$('#authorityResponse').text("");
	$('#authorityError').text("");

	
	if (confirm('Är du säker på att du vill ge denna användaren ny behörighet?')) {

		$.ajax({
			url:baseUrl + '/api/admin/authorize/user/${id}',
			type:'PUT',
			data:$("#authority option:selected").val(),
		  	contentType:'application/json',
		  	accept:'application/json',
		  	processData:false,
			complete: function(response) {
	    		
	    		if(response.status == 200){
	    			// user was granted
	    			$('#authorityResponse').text(response.responseText);
					$('.requestedAuthority').text(" Ingen just nu.");
	    		} else {
	    			// can't grant that user
	    			$('#authorityError').text(response.responseText);
	    		}
	    		
			},
			error: function (response, data, textStatus, jqXHR) {
				if(response.status != 200){
					$('#authorityError').text("Error: " + textStatus + ", " + jqXHR);
				}
			}
	    });
 }
	return false;
}

//grant higher authority
function changePassword(){
	$('#passwordResponse').text("");
	$('#passwordError').text("");
	$('#authorityResponse').text("");
	$('#authorityError').text("");
	
	if (confirm('Är du säker på att du vill ändra lösenordet?')) {

		$.ajax({
			url:baseUrl + '/api/admin/set_new_password/user/${id}',
			type:'PUT',
			data:$("input[name='password']").val(),
		  	contentType:'application/json',
		  	accept:'application/json',
		  	processData:false,
			complete: function(response) {
	    		
	    		if(response.status == 200){
	    			// user was granted
	    			$("input[name='password']").val("");
	    			$('#passwordResponse').text(response.responseText);    			
	    		} else {
	    			// can't grant that user
	    			$('#passwordError').text(response.responseText);
	    		}
	    		
			},
			error: function (response, data, textStatus, jqXHR) {
				if(response.status != 200){
					$('#passwordError').text("Error: " + textStatus + ", " + jqXHR);
				}
			}
	    });
 }
	return false;
}

$(document).ready(function() {
	$.getJSON(baseUrl + "/api/admin/user/${id}")
		.done(function(data) {
			$('.username').text(data.username);
			
			if(data.requestedAuthority == ' '){
				$('.requestedAuthority').text(" Ingen just nu.");
			} else {
				$('.requestedAuthority').text(data.requestedAuthority);
			}
			
		    $('#authority').val(data.role);
		})
		.fail(function(jqxhr, textStatus, error) {
		    var err = textStatus + ", " + error;
	        $('#authorityError').text("Något gick fel: " + err);
	        $('#passwordError').text("Något gick fel: " + err);
		});
	
	// grant authority
	$('#authorityForm').submit(function(e) {
		grantAuthority();
		e.preventDefault();
	});
	
	// change password
	$('#passwordForm').submit(function(e) {
		changePassword();
		e.preventDefault();
	});
	
});
</script>