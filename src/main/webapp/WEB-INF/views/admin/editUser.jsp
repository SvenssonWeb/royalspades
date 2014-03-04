<fieldset class="passwordSettings">
	<legend>�ndra L�senord f�r: <b><span class="username"></span></b></legend>
	<form name="passwordForm" id="passwordForm">
		<table class="formtable">
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
					<input type="Submit" value="S�tt nytt l�senord">
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
	<legend>�ndra beh�righet f�r: <span class="username"></span></legend>
	<form name="authorityForm" id="authorityForm">
	    <div><b><span class="username"></span></b> Ans�ker om beh�righet: <b><span class="requestedAuthority"></span></b></div>
		<select id="authority">
			<option value="user">Anv�ndare</option>
			<option value="shopowner">Butiks�gare</option>
			<option value="producer">Leverant�r</option>
			<option value="admin">Administrat�r</option>
		</select>
		<input type="Submit" value="�ndra">
		
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

	
	if (confirm('�r du s�ker p� att du vill ge denna anv�ndaren ny beh�righet?')) {

		$.ajax({
			url:baseUrl + '/api/admin/authorize/user/${id}',
			type:'PUT',
			data:$("#authority").find("option:selected").val(),
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
	
	if (confirm('�r du s�ker p� att du vill �ndra l�senordet?')) {

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
	        $('#authorityError').text("N�got gick fel: " + err);
	        $('#passwordError').text("N�got gick fel: " + err);
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