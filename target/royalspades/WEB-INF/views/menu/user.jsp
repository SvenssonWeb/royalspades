<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<ul>
	<li>
		<a class="menulink" id="topMenuLink1" href="main">Mina kassar</a>
	</li>
	<li>
		<a class="menulink" id="topMenuLink2" href="settings">Inställningar</a>
	</li>
	<li>
		<a class="menulink" id="topMenuLink3" href="help">Hjälp</a>
	</li>
	<li>
		<a href="<c:url value="/j_spring_security_logout" />" > Logga ut</a>
	</li>
</ul>