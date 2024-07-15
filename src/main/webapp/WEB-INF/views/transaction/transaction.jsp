<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>YOONICORN 가계부</title>
    <!-- ♣♣♣ CSS ♣♣♣ -->
    <link href="../css/inquiry.css?ver=1" rel="stylesheet"/>
    <!-- ♣♣♣ font ♣♣♣ -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- JQuery 최신 -->
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
            <h1 class="board-title">거래 내역</h1>
        </div>
        <%@ include file="/WEB-INF/views/createTransactionModel.jsp" %>
        <div class="board-container">
            <div class="qna-board-list-area">
                <table>
                    <thead>
                    <tr class="qna-board-list-head">
                        <th class="qna-board-list-date">날짜</th>
                        <th class="qna-board-list-time">시간</th>
                        <th class="qna-board-list-category">카테고리</th>
                        <th class="qna-board-list-subCategory">서브 카테고리</th>
                        <th class="qna-board-list-keyword">키워드</th>
                        <th class="qna-board-list-amount">금액</th>
                        <th class="qna-board-list-memo">메모</th>
                        <th class="qna-board-list-tags">태그</th>
                        <th class="qna-board-list-installment">할부</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="transaction" items="${transactionDtos}">
                        <tr class="qna-board-list-body">
                            <td class="qna-board-list-date">${transaction.date}</td>
                            <td class="qna-board-list-time">${transaction.time}</td>
                            <td class="qna-board-list-category">${transaction.category}</td>
                            <td class="qna-board-list-subCategory">${transaction.subCategory}</td>
                            <td class="qna-board-list-keyword">${transaction.keyword}</td>
                            <td class="qna-board-list-amount">${transaction.amount}</td>
                            <td class="qna-board-list-memo">${transaction.memo}</td>
                            <td class="qna-board-list-tags">${transaction.tags}</td>
                            <td class="qna-board-list-installment">${transaction.installment}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
