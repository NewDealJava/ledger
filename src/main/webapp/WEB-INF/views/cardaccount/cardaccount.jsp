<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>가계부</title>
    <link href="../css/cardaccount.css?ver=1" rel="stylesheet"/>
    <style>
        .main-content {
            margin-left: 180px; /* Adjust according to the width of the sidebar */
            padding: 0px;
        }
    </style>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/sidebar.jsp" %>
<div class="main-content">
    <div class="board-title-container">
        <div class="board-title-area">
        <h1 class="board-title">카드/계좌</h1>
    </div>

    <!-- Tabs for Card and Account -->
        <div class="tab-container">
        <div class="tab active" data-tab="credit">카드</div>
        <div class="tab" data-tab="account">계좌</div>
    </div>

    <!-- Board for Card and Account -->
        <div class="board-container">
        <!-- credit List -->
        <div id="credit" class="tab-content active">
            <div class="card-container" id="credit-container">
                <!-- card cards will be loaded here by AJAX -->
            </div>
        </div>

        <!-- Account List -->
        <div id="account" class="tab-content">
            <div class="card-container" id="account-container">
                <!-- Account cards will be loaded here by AJAX -->
            </div>
        </div>
    </div>
    </div>
</div>

<script>
    $(document).ready(function () {

        function loadContent(type) {
            console.log(type);
            $.ajax({
                url: type === 'card' ? '/api/card' : '/api/account',
                method: 'GET',
                success: function (data) {
                    var container = type === 'card' ? '#credit-container' : '#account-container';

                    $(container).html('');
                    data.forEach(function (item) {

                        var card = $('<div>', {class: 'card'});
                        var cardBody = $('<div>', {class: 'card-body'});

                        var nameDiv = $('<div>').append(
                            $('<strong>').text(type === 'card' ? '카드 이름: ' : '계좌 이름: '),
                            $('<span>').text(item.cname)
                        );

                        cardBody.append(nameDiv);

                        var typeDiv = $('<div>').append(
                            $('<strong>').text('타입: '),
                            $('<span>').text(item.type)
                        );

                        cardBody.append(typeDiv);

                        card.append(cardBody);
                        $(container).append(card);
                    });
                },
                error: function (xhr, status, error) {
                    console.error("AJAX Error: ", status, error);
                }
            });
        }

        $('.tab').click(function () {
            var tab_id = $(this).attr('data-tab');

            $('.tab').removeClass('active');
            $('.tab-content').removeClass('active');

            $(this).addClass('active');
            $("#" + tab_id).addClass('active');

            loadContent(tab_id);
        });

        // Load tags by default
        loadContent('card');
    });
</script>

</body>
</html>
