<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <c:if test="${not empty error}">
		<div class="errorblock">
			Your login attempt was not successful, try again.<br /> Caused :
			${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
		</div>
	</c:if>
<div id="login">

	<form id="loginForm" name="f" action="<c:url value='/j_spring_security_check' />" autocomplete="on" method="POST"> 
	    <h1>Logga in</h1> 
	    <table>
	    	<tr>
	    		<td>
	        		<label for="username" class="uname" data-icon="u" > Användarnamn eller Email </label>
	        	</td><td>
	        		<input type="text" id="username" name="j_username" required type="text" placeholder="myusername or mymail@mail.com"/>
	       		</td>
	     	</tr>
	     	<tr>
	     		<td>
	        		<label for="password" class="youpasswd" data-icon="p"> Lösenord </label>
	       		</td><td>
	          		<input type="password" id="password" name="j_password" required type="password" placeholder="eg. X8df!90EO" />
	       		</td>
	     	</tr>
	     	<tr>
	     		<td>
	        		<label for="loginkeeping">Håll mig inloggad</label>
	     		</td><td>
	     			<input type="checkbox" name="_spring_security_remember_me" id="loginkeeping" />
	     		</td>
	    	</tr>
	    	
	     	<tr>
	     		<td>
	        		<input name="submit" type="submit" value="Logga in" /> 
	     		</td><td>
	     			&nbsp;
	     		</td>
	    	</tr>
	    </table> 
	</form>
	<div class="error"></div>
</div>

<script>

$(document).ready(function() {
	$('.error').text('');
	var url = window.location.href;
		
	if(url.indexOf('?login_error=1') != -1){
		// if we tried logging in with the wrong credentials
		$('.error').text("Fel användarnamn eller lösenord!");
	}
});
</script>