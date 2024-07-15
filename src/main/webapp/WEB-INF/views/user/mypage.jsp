<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>  
  <head>
    <meta charset="UTF-8" />
    <title>가게부</title>
  <%@ include file="/WEB-INF/views/include/header.jsp"%>
      <!-- JQuery 최신 -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <!-- Sweet Alert -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
    <script type="text/javascript" src="/js/toast-alert.js"></script>
  </head>

  <body>
    <h1>Welcome ${user.name}!</h1>
    <p>마이페이지</p>
  </body>
</html>
<script>
  $(document).ready(() => {
    const successMessage = sessionStorage.getItem('successMessage');
    if (successMessage) {
        Toast.fire({
            icon: 'success',
            title: "${user.name}" + successMessage,
        });
        sessionStorage.removeItem('successMessage');
    }
});
</script>