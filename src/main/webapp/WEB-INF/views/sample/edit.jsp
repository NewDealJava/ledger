<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Sample</title>
</head>
<body>
<h1>Edit Sample</h1>
<form action="${pageContext.request.contextPath}/sample/edit" method="post">
    <input type="hidden" name="id" value="${sample.id}" />
    Title: <input type="text" name="title" value="${sample.title}" /><br />
    Content: <input type="text" name="content" value="${sample.content}" /><br />
    <input type="submit" value="Edit Sample" />
</form>
</body>
</html>
