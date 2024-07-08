<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Sample List</title>
</head>
<body>
<h1>Sample List</h1>
<a href="${pageContext.request.contextPath}/sample/add">Add Sample</a>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Content</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="samples" items="${samples}">
        <tr>
            <td>${samples.id}</td>
            <td>${samples.title}</td>
            <td>${samples.content}</td>
            <td>
                <a href="${pageContext.request.contextPath}/sample/edit/${samples.id}">Edit</a>
                <a href="${pageContext.request.contextPath}/sample/delete/${samples.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
