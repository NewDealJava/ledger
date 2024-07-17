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
                            $('<span>').text(item.nickname)
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
            document.getElementById("modal-body-card").innerHTML = '';
        }

        accountSpan.onclick = function () {
            accountModal.style.display = "none";
            document.getElementById("modal-body-account").innerHTML = '';
        }

        window.onclick = function (event) {
            if (event.target == cardModal) {
                cardModal.style.display = "none";
                document.getElementById("modal-body-card").innerHTML = '';
            }
            if (event.target == accountModal) {
                accountModal.style.display = "none";
                document.getElementById("modal-body-account").innerHTML = '';
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
                    var labelType = document.createElement('label');
                    labelType.setAttribute('for', 'edit-type-card');
                    labelType.innerText = '타입:';
                    modalBody.appendChild(labelType);

                    var selectType = document.createElement('select');
                    selectType.setAttribute('id', 'edit-type-card');
                    selectType.setAttribute('name', 'type');
                    selectType.required = true;
                    var optionCredit = document.createElement('option');
                    optionCredit.setAttribute('value', 'CREDIT');
                    optionCredit.innerText = '신용';
                    if (item.type === 'CREDIT') optionCredit.selected = true;
                    selectType.appendChild(optionCredit);
                    var optionCheck = document.createElement('option');
                    optionCheck.setAttribute('value', 'CHECK');
                    optionCheck.innerText = '체크';
                    if (item.type === 'CHECK') optionCheck.selected = true;
                    selectType.appendChild(optionCheck);
                    modalBody.appendChild(selectType);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelName = document.createElement('label');
                    labelName.setAttribute('for', 'edit-name-card');
                    labelName.innerText = '이름:';
                    modalBody.appendChild(labelName);

                    var inputName = document.createElement('input');
                    inputName.setAttribute('type', 'text');
                    inputName.setAttribute('id', 'edit-name-card');
                    inputName.setAttribute('name', 'name');
                    inputName.setAttribute('value', item.name);
                    inputName.required = true;
                    modalBody.appendChild(inputName);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelCname = document.createElement('label');
                    labelCname.setAttribute('for', 'edit-cname-card');
                    labelCname.innerText = '별칭:';
                    modalBody.appendChild(labelCname);

                    var inputCname = document.createElement('input');
                    inputCname.setAttribute('type', 'text');
                    inputCname.setAttribute('id', 'edit-cname-card');
                    inputCname.setAttribute('name', 'cname');
                    inputCname.setAttribute('value', item.nickname);
                    inputCname.required = true;
                    modalBody.appendChild(inputCname);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelBday = document.createElement('label');
                    labelBday.setAttribute('for', 'edit-bday-card');
                    labelBday.innerText = '기준일:';
                    modalBody.appendChild(labelBday);

                    var inputBday = document.createElement('input');
                    inputBday.setAttribute('type', 'number');
                    inputBday.setAttribute('id', 'edit-bday-card');
                    inputBday.setAttribute('name', 'bday');
                    inputBday.setAttribute('value', item.statementDay);
                    inputBday.required = true;
                    modalBody.appendChild(inputBday);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelAmount = document.createElement('label');
                    labelAmount.setAttribute('for', 'edit-amount-card');
                    labelAmount.innerText = '금액:';
                    modalBody.appendChild(labelAmount);

                    var inputAmount = document.createElement('input');
                    inputAmount.setAttribute('type', 'number');
                    inputAmount.setAttribute('id', 'edit-amount-card');
                    inputAmount.setAttribute('name', 'amount');
                    inputAmount.setAttribute('value', item.amount);
                    inputAmount.required = true;
                    modalBody.appendChild(inputAmount);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelMemo = document.createElement('label');
                    labelMemo.setAttribute('for', 'edit-memo-card');
                    labelMemo.innerText = '메모:';
                    modalBody.appendChild(labelMemo);

                    var textareaMemo = document.createElement('textarea');
                    textareaMemo.setAttribute('id', 'edit-memo-card');
                    textareaMemo.setAttribute('name', 'memo');
                    textareaMemo.innerText = item.memo;
                    modalBody.appendChild(textareaMemo);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelImgUrl = document.createElement('label');
                    labelImgUrl.setAttribute('for', 'edit-imgUrl-card');
                    labelImgUrl.innerText = '이미지 URL:';
                    modalBody.appendChild(labelImgUrl);

                    var inputImgUrl = document.createElement('input');
                    inputImgUrl.setAttribute('type', 'text');
                    inputImgUrl.setAttribute('id', 'edit-imgUrl-card');
                    inputImgUrl.setAttribute('name', 'imgUrl');
                    inputImgUrl.setAttribute('value', item.imgUrl);
                    modalBody.appendChild(inputImgUrl);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var inputId = document.createElement('input');
                    inputId.setAttribute('type', 'hidden');
                    inputId.setAttribute('id', 'edit-id-card');
                    inputId.setAttribute('name', 'id');
                    inputId.setAttribute('value', item.cardId);
                    modalBody.appendChild(inputId);

                } else if (action === 'delete') {
                    modalTitle.innerText = "카드 삭제";
                    modalAction.value = "delete";

                    var p = document.createElement('p');
                    p.innerText = '정말로 삭제하시겠습니까?';
                    modalBody.appendChild(p);

                    var inputId = document.createElement('input');
                    inputId.setAttribute('type', 'hidden');
                    inputId.setAttribute('id', 'delete-id-card');
                    inputId.setAttribute('name', 'id');
                    inputId.setAttribute('value', item.cardId);
                    modalBody.appendChild(inputId);
                }

                cardModal.style.display = "block";
            } else if (type === 'account') {
                debugger;
                var modalTitle = document.getElementById("modal-title-account");
                var modalAction = document.getElementById("modal-action-account");
                var modalBody = document.getElementById("modal-body-account");

                // 계좌 수정/삭제 모달 내용
                if (action === 'edit') {
                    modalTitle.innerText = "계좌 수정";
                    modalAction.value = "edit";

                    // Clear previous content
                    modalBody.innerHTML = '';

                    // Create and append elements
                    var labelType = document.createElement('label');
                    labelType.setAttribute('for', 'edit-type-account');
                    labelType.innerText = '타입:';
                    modalBody.appendChild(labelType);

                    var selectType = document.createElement('select');
                    selectType.setAttribute('id', 'edit-type-account');
                    selectType.setAttribute('name', 'type');
                    selectType.required = true;
                    var optionMoney = document.createElement('option');
                    optionMoney.setAttribute('value', 'MONEY');
                    optionMoney.innerText = '현금';
                    if (item.type === 'MONEY') optionMoney.selected = true;
                    selectType.appendChild(optionMoney);
                    var optionAccount = document.createElement('option');
                    optionAccount.setAttribute('value', 'ACCOUNT');
                    optionAccount.innerText = '계좌';
                    if (item.type === 'ACCOUNT') optionAccount.selected = true;
                    selectType.appendChild(optionAccount);
                    modalBody.appendChild(selectType);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelName = document.createElement('label');
                    labelName.setAttribute('for', 'edit-name-account');
                    labelName.innerText = '이름:';
                    modalBody.appendChild(labelName);

                    var inputName = document.createElement('input');
                    inputName.setAttribute('type', 'text');
                    inputName.setAttribute('id', 'edit-name-account');
                    inputName.setAttribute('name', 'name');
                    inputName.setAttribute('value', item.name);
                    inputName.required = true;
                    modalBody.appendChild(inputName);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelCname = document.createElement('label');
                    labelCname.setAttribute('for', 'edit-cname-account');
                    labelCname.innerText = '별칭:';
                    modalBody.appendChild(labelCname);

                    var inputCname = document.createElement('input');
                    inputCname.setAttribute('type', 'text');
                    inputCname.setAttribute('id', 'edit-cname-account');
                    inputCname.setAttribute('name', 'cname');
                    inputCname.setAttribute('value', item.cname);
                    inputCname.required = true;
                    modalBody.appendChild(inputCname);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelAmount = document.createElement('label');
                    labelAmount.setAttribute('for', 'edit-amount-account');
                    labelAmount.innerText = '금액:';
                    modalBody.appendChild(labelAmount);

                    var inputAmount = document.createElement('input');
                    inputAmount.setAttribute('type', 'number');
                    inputAmount.setAttribute('id', 'edit-amount-account');
                    inputAmount.setAttribute('name', 'amount');
                    inputAmount.setAttribute('value', item.amount);
                    inputAmount.required = true;
                    modalBody.appendChild(inputAmount);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelMemo = document.createElement('label');
                    labelMemo.setAttribute('for', 'edit-memo-account');
                    labelMemo.innerText = '메모:';
                    modalBody.appendChild(labelMemo);

                    var textareaMemo = document.createElement('textarea');
                    textareaMemo.setAttribute('id', 'edit-memo-account');
                    textareaMemo.setAttribute('name', 'memo');
                    textareaMemo.innerText = item.memo;
                    modalBody.appendChild(textareaMemo);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var labelImgUrl = document.createElement('label');
                    labelImgUrl.setAttribute('for', 'edit-imgUrl-account');
                    labelImgUrl.innerText = '이미지 URL:';
                    modalBody.appendChild(labelImgUrl);

                    var inputImgUrl = document.createElement('input');
                    inputImgUrl.setAttribute('type', 'text');
                    inputImgUrl.setAttribute('id', 'edit-imgUrl-account');
                    inputImgUrl.setAttribute('name', 'imgUrl');
                    inputImgUrl.setAttribute('value', item.imgUrl);
                    modalBody.appendChild(inputImgUrl);
                    modalBody.appendChild(document.createElement('br'));
                    modalBody.appendChild(document.createElement('br'));

                    var inputId = document.createElement('input');
                    inputId.setAttribute('type', 'hidden');
                    inputId.setAttribute('id', 'edit-id-account');
                    inputId.setAttribute('name', 'id');
                    inputId.setAttribute('value', item.ano);
                    modalBody.appendChild(inputId);

            } else if (action === 'delete') {
                    modalTitle.innerText = "계좌 삭제";
                    modalAction.value = "delete";

                    var p = document.createElement('p');
                    p.innerText = '정말로 삭제하시겠습니까?';
                    modalBody.appendChild(p);

                    var inputId = document.createElement('input');
                    inputId.setAttribute('type', 'hidden');
                    inputId.setAttribute('id', 'delete-id-account');
                    inputId.setAttribute('name', 'id');
                    inputId.setAttribute('value', item.ano);
                    modalBody.appendChild(inputId);

                }

                accountModal.style.display = "block";
            }
        }

        $("#edit-delete-card-form").submit(function (event) {

            event.preventDefault();
            var action = $("#modal-action-card").val();
            if (action === "edit") {

                var id = $("#edit-id-card").val();
                var data = {
                    type: $("#edit-type-card").val(),
                    name: $("#edit-name-card").val(),
                    cname: $("#edit-cname-card").val(),
                    bday: $("#edit-bday-card").val(),
                    amount: $("#edit-amount-card").val(),
                    memo: $("#edit-memo-card").val(),
                    imgUrl: $("#edit-imgUrl-card").val()
                };

                // Call your API to edit the cardcardSpan.onclick
                $.ajax({
                    url: '/api/card/' + id,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    success: function(response) {
                        cardModal.style.display = "none";
                        document.getElementById("modal-body-card").innerHTML = '';
                        loadContent('credit');
                    },
                    error: function(xhr, status, error) {
                        document.getElementById("modal-body-card").innerHTML = '';
                        console.error("AJAX Error: ", status, error);
                    }
                });


            } else if (action === "delete") {
                var id = $("#delete-id-card").val();

                $.ajax({
                    url: '/api/card/' + id,
                    type: 'DELETE',
                    success: function(response) {
                        alert("Card deleted successfully.");
                        document.getElementById("modal-body-card").innerHTML = '';
                        window.location.reload();
                    },
                    error: function(xhr, status, error) {
                        document.getElementById("modal-body-card").innerHTML = '';
                        alert("Error deleting card: " + error);
                    }
                });
            }
            cardModal.style.display = "none";
            loadContent('credit');
        });

        $("#edit-delete-account-form").submit(function (event) {
            event.preventDefault();
            var action = $("#modal-action-account").val();
            if (action === "edit") {
                var id = $("#edit-id-account").val();
                var data = {
                    type: $("#edit-type-account").val(),
                    name: $("#edit-name-account").val(),
                    cname: $("#edit-cname-account").val(),
                    amount: $("#edit-amount-account").val(),
                    memo: $("#edit-memo-account").val(),
                    imgUrl: $("#edit-imgUrl-account").val()
                };
                // Call your API to edit the account
                $.ajax({
                    url: '/api/account/' + id,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    success: function(response) {
                        alert("Account updated successfully.");
                        accountModal.style.display = "none";
                        document.getElementById("modal-body-account").innerHTML = ''; // Clear the modal body
                        loadContent('account');
                    },
                    error: function(xhr, status, error) {
                        alert("Error updating account: " + error);
                    }
                });

            } else if (action === "delete") {
                var id = $("#delete-id-account").val();
                // Call your API to delete the account
                $.ajax({
                    url: '/api/account/' + id,
                    type: 'DELETE',
                    success: function(response) {
                        alert("Account deleted successfully.");
                        accountModal.style.display = "none";
                        document.getElementById("modal-body-account").innerHTML = ''; // Clear the modal body
                        loadContent('account');
                    },
                    error: function(xhr, status, error) {
                        alert("Error deleting account: " + error);
                    }
                });
            }
            accountModal.style.display = "none";
            loadContent('account');
        });
    });
</script>

</body>
</html>
