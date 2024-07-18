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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .main-content {
            margin-left: 180px; /* Adjust according to the width of the sidebar */
            padding: 20px;
        }
        .date-filter-container {
            margin-bottom: 20px;
        }
        .large-number {
            font-size: 2em;
            font-weight: bold;
        }
        .flex-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .flex-item {
            flex: 1;
            text-align: center;
        }
        .section-divider {
            border-bottom: 1px solid #ccc;
            margin-bottom: 20px;
            padding-bottom: 20px;
        }
        .chart-container {
            flex: 1;
            margin: 0 10px;
        }
        .chart-container {
            flex: 1;
            margin: 0 10px; /* Add margin to prevent charts from spreading too much */
            padding: 10px; /* Add padding for a better visual separation */
            background: #f9f9f9; /* Add a background color for better contrast */
            border-radius: 8px; /* Round the corners */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Add a subtle shadow */
        }
        .chart-container canvas {
            width: 100% !important;
            height: 90% !important;
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

    <!-- Year-Month Selection -->
    <div class="date-filter-container section-divider">
        <select id="year-month-select"></select>
        <button id="filter-button">필터</button>
    </div>

    <!-- Daily and Weekly Expenses -->
    <div class="flex-container section-divider">
        <div class="chart-container">
            <h2>날짜 별 지출</h2>
            <canvas id="dailyExpensesChart"></canvas>
        </div>
        <div class="chart-container">
            <h2>주간 지출 추이</h2>
            <canvas id="weeklyExpensesChart"></canvas>
        </div>
    </div>

    <!-- Category Expenses and Monthly Income/Expense -->
    <div class="flex-container section-divider">
        <div class="chart-container">
            <h2>카테고리별 지출</h2>
            <canvas id="categoryExpensesChart"></canvas>
        </div>
        <div class="flex-item">
            <div>월간 총 수입</div>
            <div id="monthlyIncome" class="large-number"></div>
            <div>월간 총 지출</div>
            <div id="monthlyExpense" class="large-number"></div>
        </div>
    </div>
</div>

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

        $('#filter-button').click(function() {
            var selectedDate = $('#year-month-select').val();
            var selectedYear = selectedDate.split('-')[0];
            var selectedMonth = selectedDate.split('-')[1];

            $.ajax({
                url: '/api/transaction?year=' + selectedYear + '&month=' + selectedMonth,
                method: 'GET',
                success: function(data) {
                    visualizeStatistics(data);
                },
                error: function(error) {
                    console.error("Error fetching transactions", error);
                }
            });
        });

        function visualizeStatistics(transactions) {
            const dailyExpenses = {};
            const weeklyExpenses = [0, 0, 0, 0, 0]; // Assuming up to 5 weeks in a month
            const monthlyExpenses = { income: 0, expense: 0 };
            const categoryExpenses = {};

            transactions.forEach(tx => {
                const date = new Date(tx.date);
                const day = date.getDate();
                const week = Math.floor((day - 1) / 7);
                const amount = parseFloat(tx.amount.replace(',', ''));

                // Daily Expenses
                if (!dailyExpenses[day]) dailyExpenses[day] = 0;
                dailyExpenses[day] += amount;

                // Weekly Expenses
                weeklyExpenses[week] += amount;

                // Monthly Expenses
                if (amount > 0) monthlyExpenses.income += amount;
                else monthlyExpenses.expense += amount;

                // Category Expenses
                if (!categoryExpenses[tx.category]) categoryExpenses[tx.category] = 0;
                categoryExpenses[tx.category] += amount;
            });

            // Update Monthly Income and Expense
            $('#monthlyIncome').text(monthlyExpenses.income.toLocaleString());
            $('#monthlyExpense').text(monthlyExpenses.expense.toLocaleString());

            renderChart('dailyExpensesChart', 'line', '날짜 별 지출', Object.keys(dailyExpenses), Object.values(dailyExpenses));
            renderChart('weeklyExpensesChart', 'line', '주간 지출 추이', ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5'], weeklyExpenses);
            renderCategoryChart('categoryExpensesChart', 'pie', '카테고리별 지출', Object.keys(categoryExpenses), Object.values(categoryExpenses));
        }

        function renderChart(elementId, type, label, labels, data) {
            const ctx = document.getElementById(elementId).getContext('2d');
            new Chart(ctx, {
                type: type,
                data: {
                    labels: labels,
                    datasets: [{
                        label: label,
                        data: data,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        function renderCategoryChart(elementId, type, label, labels, data) {
            const ctx = document.getElementById(elementId).getContext('2d');
            const colors = generateRainbowColors(labels.length);
            new Chart(ctx, {
                type: type,
                data: {
                    labels: labels,
                    datasets: [{
                        label: label,
                        data: data,
                        backgroundColor: colors,
                        borderColor: colors,
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: true,
                            labels: {
                                color: 'rgb(75, 75, 75)'
                            }
                        }
                    }
                }
            });
        }

        function generateRainbowColors(numColors) {
            const colors = [];
            const rainbowColors = [
                'rgba(255, 0, 0, 0.5)',    // Red
                'rgba(255, 127, 0, 0.5)',  // Orange
                'rgba(255, 255, 0, 0.5)',  // Yellow
                'rgba(0, 255, 0, 0.5)',    // Green
                'rgba(0, 0, 255, 0.5)',    // Blue
                'rgba(75, 0, 130, 0.5)',   // Indigo
                'rgba(143, 0, 255, 0.5)'   // Violet
            ];
            for (let i = 0; i < numColors; i++) {
                colors.push(rainbowColors[i % rainbowColors.length]);
            }
            return colors;
        }

        // Load initial data
        $('#filter-button').click();
    });
</script>
</body>
</html>

<%--<%@ page language="java" contentType="text/html; charset=UTF-8"--%>
<%--         pageEncoding="UTF-8" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8"/>--%>
<%--    <title>YOONICORN 가계부</title>--%>
<%--    <link href="../css/inquiry.css?ver=1" rel="stylesheet"/>--%>
<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">--%>
<%--    <script src="http://code.jquery.com/jquery-latest.min.js"></script>--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>--%>
<%--    <style>--%>
<%--        .main-content {--%>
<%--            margin-left: 180px; /* Adjust according to the width of the sidebar */--%>
<%--            padding: 20px;--%>
<%--        }--%>
<%--        .date-filter-container {--%>
<%--            margin-bottom: 20px;--%>
<%--        }--%>
<%--        .large-number {--%>
<%--            font-size: 2em;--%>
<%--            font-weight: bold;--%>
<%--        }--%>
<%--        .flex-container {--%>
<%--            display: flex;--%>
<%--            justify-content: space-between;--%>
<%--            margin-bottom: 20px;--%>
<%--        }--%>
<%--        .flex-item {--%>
<%--            flex: 1;--%>
<%--            text-align: center;--%>
<%--        }--%>
<%--        .section-divider {--%>
<%--            border-bottom: 1px solid #ccc;--%>
<%--            margin-bottom: 20px;--%>
<%--            padding-bottom: 20px;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>

<%--<body>--%>

<%--<%@ include file="/WEB-INF/views/include/header.jsp" %>--%>
<%--<%@ include file="/WEB-INF/views/include/sidebar.jsp" %>--%>

<%--<div class="main-content">--%>
<%--    <div class="board-title-container">--%>
<%--        <div class="board-title-area">--%>
<%--            <h1 class="board-title">대시보드</h1>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Year-Month Selection -->--%>
<%--    <div class="date-filter-container section-divider">--%>
<%--        <select id="year-month-select"></select>--%>
<%--        <button id="filter-button">필터</button>--%>
<%--    </div>--%>

<%--    <!-- Monthly Income and Expense -->--%>
<%--    <div class="flex-container section-divider">--%>
<%--        <div class="flex-item">--%>
<%--            <div>월간 총 수입</div>--%>
<%--            <div id="monthlyIncome" class="large-number"></div>--%>
<%--        </div>--%>
<%--        <div class="flex-item">--%>
<%--            <div>월간 총 지출</div>--%>
<%--            <div id="monthlyExpense" class="large-number"></div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="section-divider">--%>
<%--        <h2>날짜 별 지출</h2>--%>
<%--        <canvas id="dailyExpensesChart"></canvas>--%>
<%--    </div>--%>

<%--    <div class="section-divider">--%>
<%--        <h2>주간 지출 추이</h2>--%>
<%--        <canvas id="weeklyExpensesChart"></canvas>--%>
<%--    </div>--%>

<%--    <div class="section-divider">--%>
<%--        <h2>카테고리별 지출</h2>--%>
<%--        <canvas id="categoryExpensesChart"></canvas>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script>--%>
<%--    $(document).ready(function () {--%>
<%--        // Populate year-month select box--%>
<%--        var today = new Date();--%>
<%--        var year = today.getFullYear();--%>
<%--        var month = today.getMonth() + 1;--%>

<%--        for (var y = year; y >= year - 10; y--) {--%>
<%--            for (var m = 12; m >= 1; m--) {--%>
<%--                var monthValue = (m < 10 ? '0' : '') + m;--%>
<%--                var option = new Option(y + '-' + monthValue, y + '-' + monthValue);--%>
<%--                $('#year-month-select').append($(option));--%>
<%--            }--%>
<%--        }--%>

<%--        // Set default value to current year-month--%>
<%--        $('#year-month-select').val(year + '-' + (month < 10 ? '0' : '') + month);--%>

<%--        $('#filter-button').click(function() {--%>
<%--            var selectedDate = $('#year-month-select').val();--%>
<%--            var selectedYear = selectedDate.split('-')[0];--%>
<%--            var selectedMonth = selectedDate.split('-')[1];--%>

<%--            $.ajax({--%>
<%--                url: '/api/transaction?year=' + selectedYear + '&month=' + selectedMonth,--%>
<%--                method: 'GET',--%>
<%--                success: function(data) {--%>
<%--                    visualizeStatistics(data);--%>
<%--                },--%>
<%--                error: function(error) {--%>
<%--                    console.error("Error fetching transactions", error);--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>

<%--        function visualizeStatistics(transactions) {--%>
<%--            const dailyExpenses = {};--%>
<%--            const weeklyExpenses = [0, 0, 0, 0, 0]; // Assuming up to 5 weeks in a month--%>
<%--            const monthlyExpenses = { income: 0, expense: 0 };--%>
<%--            const categoryExpenses = {};--%>

<%--            transactions.forEach(tx => {--%>
<%--                const date = new Date(tx.date);--%>
<%--                const day = date.getDate();--%>
<%--                const week = Math.floor((day - 1) / 7);--%>
<%--                const amount = parseFloat(tx.amount.replace(',', ''));--%>

<%--                // Daily Expenses--%>
<%--                if (!dailyExpenses[day]) dailyExpenses[day] = 0;--%>
<%--                dailyExpenses[day] += amount;--%>

<%--                // Weekly Expenses--%>
<%--                weeklyExpenses[week] += amount;--%>

<%--                // Monthly Expenses--%>
<%--                if (amount > 0) monthlyExpenses.income += amount;--%>
<%--                else monthlyExpenses.expense += amount;--%>

<%--                // Category Expenses--%>
<%--                if (!categoryExpenses[tx.category]) categoryExpenses[tx.category] = 0;--%>
<%--                categoryExpenses[tx.category] += amount;--%>
<%--            });--%>

<%--            // Update Monthly Income and Expense--%>
<%--            $('#monthlyIncome').text(monthlyExpenses.income.toLocaleString());--%>
<%--            $('#monthlyExpense').text(monthlyExpenses.expense.toLocaleString());--%>

<%--            renderChart('dailyExpensesChart', 'line', '날짜 별 지출', Object.keys(dailyExpenses), Object.values(dailyExpenses));--%>
<%--            renderChart('weeklyExpensesChart', 'line', '주간 지출 추이', ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5'], weeklyExpenses);--%>
<%--            renderCategoryChart('categoryExpensesChart', 'pie', '카테고리별 지출', Object.keys(categoryExpenses), Object.values(categoryExpenses));--%>
<%--        }--%>

<%--        function renderChart(elementId, type, label, labels, data) {--%>
<%--            const ctx = document.getElementById(elementId).getContext('2d');--%>
<%--            new Chart(ctx, {--%>
<%--                type: type,--%>
<%--                data: {--%>
<%--                    labels: labels,--%>
<%--                    datasets: [{--%>
<%--                        label: label,--%>
<%--                        data: data,--%>
<%--                        backgroundColor: 'rgba(75, 192, 192, 0.2)',--%>
<%--                        borderColor: 'rgba(75, 192, 192, 1)',--%>
<%--                        borderWidth: 1--%>
<%--                    }]--%>
<%--                },--%>
<%--                options: {--%>
<%--                    responsive: true,--%>
<%--                    scales: {--%>
<%--                        y: {--%>
<%--                            beginAtZero: true--%>
<%--                        }--%>
<%--                    }--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>

<%--        function renderCategoryChart(elementId, type, label, labels, data) {--%>
<%--            const ctx = document.getElementById(elementId).getContext('2d');--%>
<%--            const colors = generateRainbowColors(labels.length);--%>
<%--            new Chart(ctx, {--%>
<%--                type: type,--%>
<%--                data: {--%>
<%--                    labels: labels,--%>
<%--                    datasets: [{--%>
<%--                        label: label,--%>
<%--                        data: data,--%>
<%--                        backgroundColor: colors,--%>
<%--                        borderColor: colors,--%>
<%--                        borderWidth: 1--%>
<%--                    }]--%>
<%--                },--%>
<%--                options: {--%>
<%--                    responsive: true,--%>
<%--                    plugins: {--%>
<%--                        legend: {--%>
<%--                            display: true,--%>
<%--                            labels: {--%>
<%--                                color: 'rgb(75, 75, 75)'--%>
<%--                            }--%>
<%--                        }--%>
<%--                    }--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>

<%--        function generateRainbowColors(numColors) {--%>
<%--            const colors = [];--%>
<%--            const rainbowColors = [--%>
<%--                'rgba(255, 0, 0, 0.5)',    // Red--%>
<%--                'rgba(255, 127, 0, 0.5)',  // Orange--%>
<%--                'rgba(255, 255, 0, 0.5)',  // Yellow--%>
<%--                'rgba(0, 255, 0, 0.5)',    // Green--%>
<%--                'rgba(0, 0, 255, 0.5)',    // Blue--%>
<%--                'rgba(75, 0, 130, 0.5)',   // Indigo--%>
<%--                'rgba(143, 0, 255, 0.5)'   // Violet--%>
<%--            ];--%>
<%--            for (let i = 0; i < numColors; i++) {--%>
<%--                colors.push(rainbowColors[i % rainbowColors.length]);--%>
<%--            }--%>
<%--            return colors;--%>
<%--        }--%>

<%--        // Load initial data--%>
<%--        $('#filter-button').click();--%>
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>
