<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>doIBoard.jsp</title>
	</head>
	<body>
		<c:choose>
			<c:when test="${result=='iWrite-Save'}">
				<script>
				 alert("게시글이 저장 되었습니다.");
				 location.href="/inquiry";
				</script>
			</c:when>
			<c:when test="${result=='iView-Delete'}">
				<script>
				 alert("게시글이 삭제 되었습니다.");
				 location.href="/inquiry";
				</script>
			</c:when>
			<c:when test="${result=='iUpdate-Save'}">
				<script>
				 alert("게시글이 수정 되었습니다.");
				 location.href="/inquiry";
				</script>
			</c:when>
		</c:choose>
	</body>
</html>