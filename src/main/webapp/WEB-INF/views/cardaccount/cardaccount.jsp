<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        .modal-container, .modal-container2 {
            /*display: none; !* Initially hide the modal containers *!*/
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
            <h1 class="board-title">카드/계좌</h1>
        </div>

        <!-- Tabs for Card and Account -->
        <div class="tab-container">
            <div class="tab active" data-tab="credit">카드</div>
            <div class="tab" data-tab="account">계좌</div>
        </div>

        <div class="button-container">
            <div id="modal-container" class="modal-container">
                <%@ include file="/WEB-INF/views/cardaccount/createCardModal.jsp" %>
            </div>
            <div id="modal-container2" class="modal-container2">
                <%@ include file="/WEB-INF/views/cardaccount/createAccountModal.jsp" %>
            </div>
        </div>

        <!-- Board for Card and Account -->
        <div class="board-container">
            <!-- Card List -->
            <div id="credit" class="tab-content active">
                <div class="card-container" id="credit-container">
                    <!-- Card cards will be loaded here by AJAX -->
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

<!-- Modal for Edit/Delete Card -->
<div id="editDeleteCardModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <form id="edit-delete-card-form">
            <h2 id="modal-title-card"></h2>
            <input type="hidden" id="modal-action-card">
            <div id="modal-body-card">
                <!-- Content will be injected here by JavaScript -->
            </div>
            <input type="submit" value="확인">
        </form>
    </div>
</div>

<!-- Modal for Edit/Delete Account -->
<div id="editDeleteAccountModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <form id="edit-delete-account-form">
            <h2 id="modal-title-account"></h2>
            <input type="hidden" id="modal-action-account">
            <div id="modal-body-account">
                <!-- Content will be injected here by JavaScript -->
            </div>
            <input type="submit" value="확인">
        </form>
    </div>
</div>

<script>
    $(document).ready(function () {
        function loadContent(type) {
            $.ajax({
                url: type === 'credit' ? '/api/card' : '/api/account',
                method: 'GET',
                success: function (data) {
                    var container = type === 'credit' ? '#credit-container' : '#account-container';
                    $(container).html('');
                    data.forEach(function (item) {
                        var card = $('<div>', { class: 'card' });
                        var cardBody = $('<div>', { class: 'card-body' });

                        var nameDiv = $('<div>').append(
                            $('<strong>').text(type === 'credit' ? '카드 이름: ' : '계좌 이름: '),
                            $('<span>').text(item.cname)
                            );

                        cardBody.append(nameDiv);

                        var typeDiv = $('<div>').append(
                            $('<strong>').text('타입: '),
                            $('<span>').text(item.type)
                            );

                        cardBody.append(typeDiv);

                        var selectDiv;
                        if (type === 'credit') {
                            selectDiv = $('<div>', { class: 'card-select' }).append(
                                $('<select>').append(
                                    $('<option>', { value: '' }).text('옵션 선택'),
                                    $('<option>', { value: 'report' }).text('보고서 보기'),
                                    $('<option>', { value: 'history' }).text('내역 보기'),
                                    $('<option>', { value: 'exclude' }).text('분석에서 제외'),
                                    $('<option>', { value: 'edit' }).text('카드 수정'),
                                    $('<option>', { value: 'delete' }).text('카드 삭제')
                                    ).change(function () {
                                    var action = $(this).val();
                                    if (action === 'edit') {
                                        openModal('edit', item, 'credit');
                                    } else if (action === 'delete') {
                                        openModal('delete', item, 'credit');
                                    } else if (action === 'report' || action === 'history' || action === 'exclude') {
                                        alert(`${action} 선택됨`); // Placeholder for actual action
                                    }
                                    $(this).val(''); // Reset the select box
                                })
                                );
                        } else if (type === 'account') {
                            selectDiv = $('<div>', { class: 'card-select' }).append(
                                $('<select>').append(
                                    $('<option>', { value: '' }).text('옵션 선택'),
                                    $('<option>', { value: 'report' }).text('보고서 보기'),
                                    $('<option>', { value: 'history' }).text('내역 보기'),
                                    $('<option>', { value: 'exclude' }).text('분석에서 제외'),
                                    $('<option>', { value: 'edit' }).text('계좌 수정'),
                                    $('<option>', { value: 'delete' }).text('계좌 삭제')
                                    ).change(function () {
                                    var action = $(this).val();
                                    if (action === 'edit') {
                                        openModal('edit', item, 'account');
                                    } else if (action === 'delete') {
                                        openModal('delete', item, 'account');
                                    } else if (action === 'report' || action === 'history' || action === 'exclude') {
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
            if (tab_id === 'credit') {
                $('#modal-container2').hide();
                $('#modal-container').show();
            } else {
                $('#modal-container').hide();
                $('#modal-container2').show();
            }
        });

        // Load credit by default and show the modal container
        loadContent('credit');
        $('#modal-container').show();
        $('#modal-container2').hide();

        var cardModal = document.getElementById("editDeleteCardModal");
        var accountModal = document.getElementById("editDeleteAccountModal");
        var cardSpan = cardModal.getElementsByClassName("close")[0];
        var accountSpan = accountModal.getElementsByClassName("close")[0];

        cardSpan.onclick = function () {
            cardModal.style.display = "none";
        }

        accountSpan.onclick = function () {
            accountModal.style.display = "none";
        }

        window.onclick = function (event) {
            if (event.target == cardModal) {
                cardModal.style.display = "none";
            }
            if (event.target == accountModal) {
                accountModal.style.display = "none";
            }
        }

        function openModal(action, item, type) {
            if (type === 'credit') {
                var modalTitle = document.getElementById("modal-title-card");
                var modalAction = document.getElementById("modal-action-card");
                var modalBody = document.getElementById("modal-body-card");

                if (action === 'edit') {
                    modalTitle.innerText = "카드 수정";
                    modalAction.value = "edit";
                    modalBody.innerHTML = `
                        <label for="edit-name-card">이름:</label>
                        <input type="text" id="edit-name-card" name="name" value="${item.cname}" required><br><br>
                    `;
                } else if (action === 'delete') {
                    modalTitle.innerText = "카드 삭제";
                    modalAction.value = "delete";
                    modalBody.innerHTML = `
                        <p>정말로 삭제하시겠습니까?</p>
                        <input type="hidden" id="delete-id-card" name="id" value="${item.id}">
                    `;
                }

                cardModal.style.display = "block";
            } else if (type === 'account') {
                var modalTitle = document.getElementById("modal-title-account");
                var modalAction = document.getElementById("modal-action-account");
                var modalBody = document.getElementById("modal-body-account");

                // 계좌 수정/삭제 모달 내용
                if (action === 'edit') {
                    modalTitle.innerText = "계좌 수정";
                    modalAction.value = "edit";
                    modalBody.innerHTML = `
                        <label for="edit-name-account">이름:</label>
                        <input type="text" id="edit-name-account" name="name" value="${item.cname}" required><br><br>
                    `;
                } else if (action === 'delete') {
                    modalTitle.innerText = "계좌 삭제";
                    modalAction.value = "delete";
                    modalBody.innerHTML = `
                        <p>정말로 삭제하시겠습니까?</p>
                        <input type="hidden" id="delete-id-account" name="id" value="${item.id}">
                    `;
                }

                accountModal.style.display = "block";
            }
        }

        $("#edit-delete-card-form").submit(function (event) {
            event.preventDefault();
            var action = $("#modal-action-card").val();
            if (action === "edit") {
                var id = $("#delete-id-card").val();
                var name = $("#edit-name-card").val();
                // Call your API to edit the card
                // $.ajax({ ... });
            } else if (action === "delete") {
                var id = $("#delete-id-card").val();
                // Call your API to delete the card
                // $.ajax({ ... });
            }
            cardModal.style.display = "none";
            loadContent('credit');
        });

        $("#edit-delete-account-form").submit(function (event) {
            event.preventDefault();
            var action = $("#modal-action-account").val();
            if (action === "edit") {
                var id = $("#delete-id-account").val();
                var name = $("#edit-name-account").val();
                // Call your API to edit the account
                // $.ajax({ ... });
            } else if (action === "delete") {
                var id = $("#delete-id-account").val();
                // Call your API to delete the account
                // $.ajax({ ... });
            }
            accountModal.style.display = "none";
            loadContent('account');
        });
    });
</script>

</body>
</html>
