<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>가계부</title>
    <link href="../css/categorytag.css?ver=1" rel="stylesheet"/>
    <style>
        .main-content {
            margin-left: 180px; /* Adjust according to the width of the sidebar */
            padding: 0px;
        }

        .modal-container {
            display: none; /* Initially hide the modal container */
        }

        .button-container {
            height: 40px; /* Set a fixed height */
            position: relative;
            margin-bottom: 20px;
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
            <h1 class="board-title">카테고리/태그</h1>
        </div>

        <!-- Tabs for Tag and Category -->
        <div class="tab-container">
            <div class="tab active" data-tab="tag">태그</div>
            <div class="tab" data-tab="category">카테고리</div>
        </div>

        <div class="button-container">
            <div id="modal-container" class="modal-container">
                <%@ include file="/WEB-INF/views/categorytag/createTagModal.jsp" %>
            </div>
        </div>

        <!-- Board for Tag and Category -->
        <div class="board-container">
            <!-- Tag List -->
            <div id="tag" class="tab-content active">
                <div class="card-container" id="tag-container">
                    <!-- Tag cards will be loaded here by AJAX -->
                </div>
            </div>

            <!-- Category List -->
            <div id="category" class="tab-content">
                <div class="card-container" id="category-container">
                    <!-- Category cards will be loaded here by AJAX -->
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
                url: type === 'tag' ? '/api/tag' : '/api/category/all',
                method: 'GET',
                success: function (data) {
                    var container = type === 'tag' ? '#tag-container' : '#category-container';

                    $(container).html('');
                    data.forEach(function (item) {
                        var card = $('<div>', {class: 'card'});
                        var cardBody = $('<div>', {class: 'card-body'});

                        var nameDiv = $('<div>').append(
                            $('<strong>').text(type === 'tag' ? '태그 이름: ' : '카테고리 이름: '),
                            $('<span>').text(item.name)
                            );

                        cardBody.append(nameDiv);

                        if (type !== 'tag') {
                            var typeDiv = $('<div>').append(
                                $('<strong>').text('카테고리 타입: '),
                                $('<span>').text(item.type)
                                );
                            cardBody.append(typeDiv);
                        }

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

            // Show or hide the modal container based on the active tab
            if (tab_id === 'tag') {
                $('#modal-container').show();
            } else {
                $('#modal-container').hide();
            }
        });

        // Load tags by default and show the modal container
        loadContent('tag');
        $('#modal-container').show();
    });
</script>

</body>
</html>
