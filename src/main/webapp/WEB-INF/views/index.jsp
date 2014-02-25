<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
	<script type="text/javascript">var baseUrl = "${contextPath}";</script>

    <div class="headerwrapper">
    	<!-- link differently, for different roles in the system -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<!-- admin -->		
			  <h2 class="royal"><a class="homeclick" href="/royalspades/admin/">Royal Spader</a></h2>  
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_SUPERVISOR')">	
		    <!-- producer -->			
			  <h2 class="royal"><a class="homeclick" href="/royalspades/producer/">Royal Spader</a></h2>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_MODERATOR')">	
		    <!-- shop owner -->	
			  <h2 class="royal"><a class="homeclick" href="/royalspades/shopowner/">Royal Spader</a></h2>
		</sec:authorize>
	    <sec:authorize access="hasRole('ROLE_USER')">	
	        <!-- user -->			
			  <h2 class="royal"><a class="homeclick" href="/royalspades/home/">Royal Spader</a></h2>
		</sec:authorize> 
	    <sec:authorize access="isAnonymous()">	
	        <!-- at login,logout,signup -->			
			  <h2 class="royal"><a class="homeclick" href="/royalspades/">Royal Spader</a></h2>
		</sec:authorize>
    
    
				<div class="headermenu">
					
				</div>
			</div>
		<div class="mainwrapper">
			
			<div class="bodywrapper">

           
            
				<div class="maincontent">
                
					<p>
						Aktivera Javascript för att kunna använda denna sida!
					</p>
				</div>
			</div>
			
		</div>
		
<%@ include file="/WEB-INF/views/common/footer.jsp" %>