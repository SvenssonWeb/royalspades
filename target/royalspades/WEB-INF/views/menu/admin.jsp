<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<ul>
	<li>
		<a class="menulink" href="shops">Butiker</a>
	</li>
	<li>
		<a class="menulink" href="suppliers">Leverantörer</a>
	</li>
	<li>
		<a class="menulink" href="categories">Varukategorier</a>
	</li>
	<li>
		<a class="menulink" href="settings">Inställningar</a>
	</li>	
	<li>
		<a class="menulink" href="users">Användare</a>
	</li>	
	<li>
		<a class="menulink" href="help">Hjälp</a>
	</li>
	<li>
		<a class="menulink" href="apihelp">API Hjälp</a>
	</li>	
	<li>
		<a href="<c:url value="/j_spring_security_logout" />" > Logga ut</a>
	</li>
</ul>
