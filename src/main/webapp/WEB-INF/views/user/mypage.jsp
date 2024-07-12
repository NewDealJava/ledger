<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  
  <c:if test="${ user != null }">
    <script>
      alert("${user.name}님 환영합니다.");
    </script>
  </c:if>
 
  <head>
    <meta charset="UTF-8" />
    <title>가게부</title>
  </head>
  <%@ include file="/WEB-INF/views/include/header.jsp"%>

  <body>
    <h1>Welcome ${user.name}!</h1>
    <p>마이페이지</p>
  </body>
</html>
