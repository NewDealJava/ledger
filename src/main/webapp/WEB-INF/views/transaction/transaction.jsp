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

    <script>
        $(document).ready(function () {
            // Populate year-month select box
            var today = new Date();
            var year = today.getFullYear();
            var month = today.getMonth() + 1;

            for (var y = year; y >= year - 10; y--) {
                for (var m = 12; m >= 1; m--) {
                    var monthValue = (m < 10 ? '0' : '') + m;
                    var option = new Option(y + '-' + monthValue, y + '-' + monthValue);
                    $('#year-month-select').append($(option));
                }
            }

            // Set default value to current year-month
            $('#year-month-select').val(year + '-' + (month < 10 ? '0' : '') + month);

            function loadTransactions(year, month) {
                $.ajax({
                    url: '/api/transaction',
                    type: 'GET',
                    data: {
                        year: year,
                        month: month
                    },
                    success: function (data) {
                        var tbody = $('#transaction-table tbody');
                        tbody.empty();
                        data.forEach(function (transaction) {
                            var row = '<tr class="qna-board-list-body">' +
                                '<td class="qna-board-list-date">' + transaction.date + '</td>' +
                                '<td class="qna-board-list-time">' + transaction.time + '</td>' +
                                '<td class="qna-board-list-category">' + transaction.category + '</td>' +
                                '<td class="qna-board-list-subCategory">' + transaction.subCategory + '</td>' +
                                '<td class="qna-board-list-keyword">' + transaction.keyword + '</td>' +
                                '<td class="qna-board-list-amount">' + transaction.amount + '</td>' +
                                '<td class="qna-board-list-memo">' + transaction.memo + '</td>' +
                                '<td class="qna-board-list-tags">' + transaction.tags + '</td>' +
                                '<td class="qna-board-list-installment">' + transaction.installment + '</td>' +
                                '<td><button class="edit-button" data-id="' + transaction.tno + '">수정</button></td>' +
                                '<td><button class="delete-button" data-id="' + transaction.tno + '">삭제</button></td>' +
                                '</tr>';
                            tbody.append(row);
                        });

                        // Add click event for edit buttons
                        $('.edit-button').click(function () {
                            var id = $(this).data('id');
                            loadTransactionById(id);
                        });

                        // Add click event for delete buttons
                        $('.delete-button').click(function () {
                            var id = $(this).data('id');
                            deleteTransactionById(id);
                        });


                    },
                    error: function (xhr, status, error) {
                        alert("Error fetching transactions: " + error);
                    }
                });
            }

            function loadTransactionById(id) {
                // debugger;
                $.ajax({
                    url: '/api/transaction/' + id,
                    type: 'GET',
                    success: function (transaction) {
                        // debugger;
                        if (transaction.type === 'EXPENSE') {
                            openTab(event, 'Expense');
                        } else if (transaction.type === 'INCOME') {
                            openTab(event, 'Income');
                        }

                        // Load categories and subcategories first
                        // loadCategories('EXPENSE', function() {
                        //     loadSubcategories(transaction.category, 'EXPENSE', function() {
                        //         $('#expense-category').val(transaction.category);
                        //         $('#expense-subcategory').val(transaction.subCategory);
                        //     });
                        // });
                        // loadTags('EXPENSE', function() {
                        //     $('#expense-tags').val(transaction.tags);
                        //     matchTags(transaction.tags, 'EXPENSE');
                        // });
                        // loadSources('EXPENSE', function() {
                        //     $('#expense-source').val(transaction.source);
                        // });

                        // Populate the form with the transaction data
                        // $('#transaction-id').val(transaction.id);
                        $('#expense-keyword').val(transaction.keyword);
                        $('#expense-amount').val(transaction.samount);
                        $('#expense-installment').val(transaction.installment);
                        $('#expense-date').val(transaction.date);
                        $('#expense-time').val(transaction.time);
                        $('#expense-memo').val(transaction.memo);

                        // Open the modal
                        $('#myModal').css('display', 'block');
                    },
                    error: function (xhr, status, error) {
                        alert("Error loading transaction: " + error);
                    }
                });
            }

            function deleteTransactionById(id) {
                if (confirm("Are you sure you want to delete this transaction?")) {
                    $.ajax({
                        url: '/api/transaction/' + id,
                        type: 'DELETE',
                        success: function (result) {
                            alert("Transaction deleted successfully");
                            var selectedDate = $('#year-month-select').val();
                            var [selectedYear, selectedMonth] = selectedDate.split('-');
                            loadTransactions(selectedYear, selectedMonth);
                        },
                        error: function (xhr, status, error) {
                            alert("Error deleting transaction: " + error);
                        }
                    });
                }
            }


            $('#filter-button').click(function () {
                var selectedDate = $('#year-month-select').val();
                var [selectedYear, selectedMonth] = selectedDate.split('-');
                loadTransactions(selectedYear, selectedMonth);
            });


            // Load transactions for the current year and month on page load
            loadTransactions(year, month);
        });
    </script>

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

        <!-- Year-Month Selection -->
        <div class="date-filter-container">
            <select id="year-month-select"></select>
            <button id="filter-button">필터</button>
        </div>

        <%@ include file="/WEB-INF/views/transaction/createTransactionModal.jsp" %>
        <div class="board-container">
            <div class="qna-board-list-area">
                <table id="transaction-table">
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
                    <!-- Dynamic content will be loaded here via AJAX -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
