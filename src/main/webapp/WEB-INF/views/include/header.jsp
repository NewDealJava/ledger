<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
		<title>YOONICORN 가계부</title>
		<link rel="stylesheet" type="text/css" href="../css/include/global.css?ver=1">
		<link rel="stylesheet" type="text/css" href="../css/include/header.css?ver=1">
		</head>
		<header class="header">
			<div class="logo">        
				<h1>VISUAL BANK</h1>
                <a href="/#menu=dashboard">
                    x<img src="https://dfrlippt5ud4x.cloudfront.net/web/visual_logo_beta_v3.png" width="160"/>
                </a>
            </div>
            <ul class="nav-bar">
                <%-- <c:if test="${session_id==null }"> --%>
                <li><a href="sign-in" class="sign-in">로그인</a></li>
                <%-- </c:if> --%>
                <%-- <c:if test="${session_id!=null }"> --%>
                <%-- <li class="nav"><a class="headerNav" href="#">${session_name }님</a></li>
                <li class="nav"><a class="headerNav" href="doLogout">로그아웃</a></li> --%>
                <%-- </c:if> --%>
            </ul>
		</header>
	</html>