<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
		<link href="<c:url value="/resources/theme/standard.css" />" rel="stylesheet">
		<link href="<c:url value="/resources/theme/shop.css" />" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script src="http://datatables.net/download/build/jquery.dataTables.min.js"></script>
		<script src="<c:url value="/resources/scripts/JsonParse.js" />"></script>
		
		<!-- Will load different scripts, for different roles in the system -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<!-- admin -->		
			<script src="<c:url value="/resources/theme/siteAdmin.js" />"></script>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_SUPERVISOR')">	
		    <!-- producer -->			
			<script src="<c:url value="/resources/theme/siteProducer.js" />"></script>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_MODERATOR')">	
		    <!-- shop owner -->
            <script src="<c:url value="/resources/scripts/ShopScript.js" />"></script>
			<script src="<c:url value="/resources/theme/siteShopOwner.js" />"></script>
		</sec:authorize>
	    <sec:authorize access="hasRole('ROLE_USER')">	
	        <!-- user -->			
			<script src="<c:url value="/resources/theme/siteCustomer.js" />"></script>
		</sec:authorize> 
	    <sec:authorize access="isAnonymous()">	
	        <!-- at login,logout,signup -->			
			<script src="<c:url value="/resources/theme/siteDefault.js" />"></script>
		</sec:authorize>
		
		<title>&spades; Royal Spades &spades;</title>
    </head>
	
	<body>