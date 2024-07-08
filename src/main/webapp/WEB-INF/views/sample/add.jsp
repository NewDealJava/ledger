<html>
<head>
    <title>Add Sample</title>
</head>
<body>
<h1>Add Sample</h1>
<form action="${pageContext.request.contextPath}/sample/add" method="post">
    Title: <input type="text" name="title" /><br />
    Content: <input type="text" name="content" /><br />
    <input type="submit" value="Add Sample" />
</form>
</body>
</html>
