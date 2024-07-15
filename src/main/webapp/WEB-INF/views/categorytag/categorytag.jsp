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
        .card {
            position: relative;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 10px;
            background-color: #fff;
        }
        .card-select {
            position: absolute;
            top: 10px;
            right: 10px;
            display: none;
        }
        .card:hover .card-select {
            display: block;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
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

<!-- Modal for Edit/Delete -->
<div id="editDeleteModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <form id="edit-delete-form">
            <h2 id="modal-title"></h2>
            <input type="hidden" id="modal-action">
            <div id="modal-body">
                <!-- Content will be injected here by JavaScript -->
            </div>
            <input type="submit" value="확인">
        </form>
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

                        var selectDiv;
                        if (type === 'tag') {
                            selectDiv = $('<div>', {class: 'card-select'}).append(
                                $('<select>').append(
                                    $('<option>', {value: ''}).text('옵션 선택'),
                                    $('<option>', {value: 'report'}).text('보고서 보기'),
                                    $('<option>', {value: 'history'}).text('내역 보기'),
                                    $('<option>', {value: 'exclude'}).text('분석에서 제외'),
                                    $('<option>', {value: 'edit'}).text('태그 수정'),
                                    $('<option>', {value: 'delete'}).text('태그 삭제')
                                    ).change(function () {
                                    var action = $(this).val();
                                    if (action === 'edit') {
                                        openModal('edit', item);
                                    } else if (action === 'delete') {
                                        openModal('delete', item);
                                    } else if (action === 'report' || action === 'history' || action === 'exclude') {
                                        alert(`${action} 선택됨`); // Placeholder for actual action
                                    }
                                    $(this).val(''); // Reset the select box
                                })
                                );
                        } else if (type === 'category') {
                            selectDiv = $('<div>', {class: 'card-select'}).append(
                                $('<select>').append(
                                    $('<option>', {value: ''}).text('옵션 선택'),
                                    $('<option>', {value: 'report'}).text('보고서 보기'),
                                    $('<option>', {value: 'history'}).text('내역 보기'),
                                    $('<option>', {value: 'exclude'}).text('분석에서 제외')
                                    ).change(function () {
                                    var action = $(this).val();
                                    if (action === 'report' || action === 'history' || action === 'exclude') {
                                        alert(`${action} 선택됨`); // Placeholder for actual action
                                    }
                                    $(this).val(''); // Reset the select box
                                })
                                );
                        }

                        card.append(cardBody);
                        card.append(selectDiv);
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

        var modal = document.getElementById("editDeleteModal");
        var span = document.getElementsByClassName("close")[0];

        span.onclick = function () {
            modal.style.display = "none";
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        function openModal(action, item) {
            var modalTitle = document.getElementById("modal-title");
            var modalAction = document.getElementById("modal-action");
            var modalBody = document.getElementById("modal-body");

            // debugger;
            if (action === 'edit') {
                modalTitle.innerText = "수정";
                modalAction.value = "edit";

                // Create label
                var label = document.createElement('label');
                label.setAttribute('for', 'edit-name');
                label.innerText = '이름:';

                // Create input for name
                var inputName = document.createElement('input');
                inputName.setAttribute('type', 'text');
                inputName.setAttribute('id', 'edit-name');
                inputName.setAttribute('name', 'name');
                inputName.setAttribute('value', item.name);
                inputName.required = true;

                // Create hidden input for id
                var inputId = document.createElement('input');
                inputId.setAttribute('type', 'hidden');
                inputId.setAttribute('id', 'edit-id');
                inputId.setAttribute('name', 'id');
                inputId.setAttribute('value', item.tno);

                // Append elements to modal body
                modalBody.appendChild(label);
                modalBody.appendChild(inputName);
                modalBody.appendChild(document.createElement('br'));
                modalBody.appendChild(document.createElement('br'));
                modalBody.appendChild(inputId);

            } else if (action === 'delete') {
                modalTitle.innerText = "삭제";
                modalAction.value = "delete";
                modalBody.innerHTML = `
                    <p>정말로 삭제하시겠습니까?</p>
                    <input type="hidden" id="delete-id" name="id" value="${item.id}">
                `;
            }

            modal.style.display = "block";
        }

        $("#edit-delete-form").submit(function (event) {
            event.preventDefault();
            var action = $("#modal-action").val();
            if (action === "edit") {

                // Edit action
                var id = $("#edit-id").val();  // 수정된 부분
                var name = $("#edit-name").val();

                $.ajax({
                    url: '/api/tag/' + id,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        name: name
                    }),
                    success: function(response) {
                        // Handle success
                        alert('Tag updated successfully.');
                        modal.style.display = "none";
                        loadContent($('.tab.active').data('tab'));
                    },
                    error: function(xhr, status, error) {
                        // Handle error
                        alert('Failed to update tag: ' + xhr.responseText);
                    }
                });

            } else if (action === "delete") {
                // Delete action
                var id = $("#delete-id").val();
                // Call your API to delete the item
                // $.ajax({ ... });
            }
            modal.style.display = "none";
            loadContent($('.tab.active').data('tab'));
        });
    });
</script>

</body>
</html>
