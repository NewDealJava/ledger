<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    .sidebar {
        width: 180px;
        height: calc(100% - 60px); /* Adjust according to your header height */
        position: fixed;
        top: 60px; /* Adjust according to your header height */
        left: 0;
        background-color: rgba(217, 216, 216, 0.68);
        padding-top: 20px;
        z-index: 1000;
    }

    .sidebar a {
        padding: 10px 15px;
        text-decoration: none;
        font-size: 18px;
        color: black;
        display: block;
    }

    .sidebar a:hover {
        background-color: whitesmoke;
    }
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<div class="sidebar">
    <li><a href="<c:url value='/view/dashboard' />">대시보드</a></li>
    <li><a href="<c:url value='/view/transaction' />">수입/지출 내역</a></li>
    <li><a href="<c:url value='/view/cardaccount' />">카드/계좌</a></li>
    <li><a href="<c:url value='/view/categorytag' />">카테고리/태그</a></li>
    <li><a href="<c:url value='/calendar' />">달력</a></li>
    <li><a href="<c:url value='/view/report' />">보고서</a></li>
</div>
