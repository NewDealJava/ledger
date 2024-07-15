<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>YOONICORN 가계부</title>
    <link href="../css/inquiry.css?ver=1" rel="stylesheet"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <style>
        .main-content {
            margin-left: 180px; /* Adjust according to the width of the sidebar */
            padding: 0px;
        }
    </style>
</head>

<body>

<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/sidebar.jsp" %>

<div class="main-content">
    <div class="board-title-container">
        <div class="board-title-area">
            <h1 class="board-title">대시보드</h1>
        </div>
    </div>
</div>
</body>
</html>
