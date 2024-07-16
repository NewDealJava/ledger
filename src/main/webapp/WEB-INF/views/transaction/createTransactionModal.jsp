<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="../css/createModal.css" rel="stylesheet">

    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        function submitExpenseForm(event) {
            event.preventDefault();
            const form = document.getElementById("expense-form");
            const formData = new FormData(form);
            const jsonObject = {};

            let sourceData = formData.get('source').split(' - ');
            jsonObject['sourceType'] = sourceData[0];
            jsonObject['sourceId'] = sourceData[1];

            formData.forEach((value, key) => {
                if ( key !== 'source') {
                    jsonObject[key] = value;
                }
            });
            if(jsonObject.transactionId === ""){ // 생성
                debugger;
                fetch('/api/transaction', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams(jsonObject).toString()
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        resetFormAndCloseModal('expense-form');
                        window.location.reload();
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });

            } else{  // 수정
                fetch('/api/transaction/' + jsonObject.transactionId, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams(jsonObject).toString()
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        resetFormAndCloseModal('expense-form');
                        window.location.reload();
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });

            }

        }

        function submitIncomeForm(event) {
            event.preventDefault();
            const form = document.getElementById("income-form");
            const formData = new FormData(form);
            const jsonObject = {};

            let sourceData = formData.get('source').split(' - ');
            jsonObject['sourceType'] = sourceData[0];
            jsonObject['sno'] = sourceData[1];

            let rtypeValue = formData.get('rtype');
            jsonObject['rtype'] = rtypeValue;

            formData.forEach((value, key) => {
                if (key !== 'rtype' && key !== 'source') {
                    jsonObject[key] = value;
                }
            });

            fetch('/api/transaction', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams(jsonObject).toString()
            })
                .then(response => {
                    console.log(response);
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    resetFormAndCloseModal('income-form');
                    window.location.reload();
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }

        function resetFormAndCloseModal(formId) {

            const form = document.getElementById(formId);
            form.reset();
            var modal = document.getElementById("myModal");
            modal.style.display = "none";
            const selectedButtons = form.querySelectorAll(".tag-button.selected");
            selectedButtons.forEach(button => {
                button.classList.remove("selected");
            });
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            var modal = document.getElementById("myModal");
            var btn = document.getElementById("openModalButton");
            var span = document.getElementsByClassName("close")[0];

            btn.onclick = function () {
                modal.style.display = "block";
                openTab(event, 'Expense');
            }

            span.onclick = function () {
                modal.style.display = "none";
                resetFormAndCloseModal('expense-form');
                resetFormAndCloseModal('income-form');
            }

            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                    resetFormAndCloseModal('expense-form');
                    resetFormAndCloseModal('income-form');
                }
            }

            loadCategories('EXPENSE');
            loadCategories('INCOME');
            loadTags('EXPENSE');
            loadTags('INCOME');
            loadSources('EXPENSE');
            loadSources('INCOME');
        });

        function openTab(evt, tabName) {
            var i, tabcontent, tablinks;

            tabcontent = document.getElementsByClassName("tab-content");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }

            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }

            document.getElementById(tabName).style.display = "block";
            evt.currentTarget.className += " active";
        }

        function loadCategories(type) {
            const categorySelect = type === 'EXPENSE' ? document.getElementById("expense-category") : document.getElementById("income-category");

            $.ajax({
                url: '/api/category',
                method: 'GET',
                data: {type: type},
                dataType: 'json',
                success: function (data) {
                    data.forEach(function (category) {
                        const option = document.createElement("option");
                        option.value = category.cno;
                        option.text = category.name;
                        categorySelect.add(option);
                    });

                    updateSubcategories(type);
                },
                error: function (error) {
                    console.error('Error loading categories:', error);
                }
            });
        }

        function updateSubcategories(type) {
            const categorySelect = type === 'EXPENSE' ? document.getElementById("expense-category") : document.getElementById("income-category");
            const subcategorySelect = type === 'EXPENSE' ? document.getElementById("expense-subcategory") : document.getElementById("income-subcategory");
            const selectedCategory = categorySelect.value;

            subcategorySelect.innerHTML = "";

            $.ajax({
                url: '/api/category/subcategory',
                method: 'GET',
                data: {parentCno: selectedCategory},
                dataType: 'json',
                success: function (data) {
                    data.forEach(function (subcategory) {
                        const option = document.createElement("option");
                        option.value = subcategory.cno;
                        option.text = subcategory.name;
                        subcategorySelect.add(option);
                    });
                },
                error: function (error) {
                    console.error('Error loading subcategories:', error);
                }
            });
        }

        function loadTags(type) {
            const tagContainer = type === 'EXPENSE' ? document.getElementById("expense-tag-container") : document.getElementById("income-tag-container");
            const hiddenInput = type === 'EXPENSE' ? document.getElementById("expense-tags") : document.getElementById("income-tags");

            $.ajax({
                url: '/api/tag',
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    data.forEach(function (tag) {
                        const button = document.createElement("button");
                        button.type = "button";
                        button.className = "tag-button";
                        button.textContent = tag.name;
                        button.dataset.tagId = tag.tno;
                        button.onclick = function () {
                            this.classList.toggle("selected");
                            updateSelectedTags(hiddenInput, tagContainer);
                        };
                        tagContainer.appendChild(button);
                    });
                },
                error: function (error) {
                    console.error('Error loading tags:', error);
                }
            });
        }

        function updateSelectedTags(hiddenInput, tagContainer) {

            const selectedTags = [];
            const buttons = tagContainer.getElementsByClassName("tag-button");
            for (let button of buttons) {
                if (button.classList.contains("selected")) {
                    selectedTags.push(button.dataset.tagId);
                }
            }
            hiddenInput.value = selectedTags.join(",");
        }

        function loadSources(type) {
            const sourceSelect = type === 'EXPENSE' ? document.getElementById("expense-source") : document.getElementById("income-source");

            $.ajax({
                url: '/api/transaction/source',
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    data.forEach(function (source) {
                        const option = document.createElement("option");
                        option.value = source.sourceType + ' - ' + source.sno;
                        option.text = source.sourceType + ' - ' + source.subSourceType + ' - ' + source.cname;
                        sourceSelect.add(option);
                    });

                },
                error: function (error) {
                    console.error('Error loading sources:', error);
                }
            });
        }
    </script>
</head>
<body>

<div class="container">
    <!-- Trigger/Open The Modal -->
    <button id="openModalButton" class="open-modal-button">+</button>
</div>

<!-- The Modal -->
<div id="myModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">
        <span class="close">&times;</span>

        <!-- Tab links -->
        <div class="tab">
            <button class="tablinks" onclick="openTab(event, 'Expense')">지출</button>
            <button class="tablinks" onclick="openTab(event, 'Income')">수입</button>
        </div>

        <!-- Tab content -->
        <div id="Expense" class="tab-content">
            <form id="expense-form" onsubmit="submitExpenseForm(event)">
                <h3>지출</h3>

                <label for="expense-transactionId">ID:</label>
                <input type="hidden" id="expense-transactionId" name="transactionId"><br><br>

                <label for="expense-type">타입:</label>
                <input type="text" id="expense-type" name="transactionType" value="EXPENSE" readonly><br><br>

                <label for="expense-category">카테고리:</label>
                <select id="expense-category" name="categoryId" onchange="updateSubcategories('EXPENSE')">
                    <!-- Category options will be populated dynamically -->
                </select><br><br>

                <label for="expense-subcategory">세부카테고리:</label>
                <select id="expense-subcategory" name="subCategoryId">
                    <!-- Subcategory options will be populated based on category selection -->
                </select><br><br>

                <label for="expense-source">거래수단: </label>
                <select id="expense-source" name="source">
                    <!-- Source options will be populated dynamically -->
                </select><br><br>

                <label for="expense-keyword">지출내역: </label>
                <input type="text" id="expense-keyword" name="keyword"><br><br>

                <label for="expense-amount">지출금액:</label>
                <input type="number" id="expense-amount" name="amount" required><br><br>

                <label for="expense-installment">할부: </label>
                <select id="expense-installment" name="installment">
                    <option value=1>일시불</option>
                    <% for (int i = 2; i <= 36; i++) { %>
                    <option value="<%= i %>"><%= i %>개월</option>
                    <% } %>
                </select><br><br>

                <label for="expense-tag-container">태그: </label>
                <div id="expense-tag-container">
                    <!-- Tag buttons will be populated dynamically -->
                </div>
                <input type="hidden" id="expense-tags" name="tagIdList"><br><br>

                <div class="form-row">
                    <label for="expense-date">날짜: </label>
                    <input type="date" id="expense-date" name="date" required>
                    <label for="expense-time">시간: </label>
                    <input type="time" id="expense-time" name="time" required>
                </div>
                <br>

                <label for="expense-rtype">반복주기: </label>
                <select id="expense-rtype" name="repeatType">
                    <option value="NONE">없음</option>
                    <option value="MONTHLY">월간</option>
                    <option value="WEEKLY">주간</option>
                </select><br><br>

                <label for="expense-memo">메모:</label>
                <textarea id="expense-memo" name="memo"></textarea><br><br>

                <label for="expense-imageUrl">이미지: </label>
                <input type="text" id="expense-imageUrl" name="imageUrl"><br><br>

                <input type="submit" value="거래내역 추가">
            </form>
        </div>

        <div id="Income" class="tab-content">
            <form id="income-form" onsubmit="submitIncomeForm(event)">
                <h3>수입</h3>

                <label for="income-transactionId">ID:</label>
                <input type="hidden" id="income-transactionId" name="transactionId"><br><br>

                <label for="income-type">타입:</label>
                <input type="text" id="income-type" name="type" value="INCOME" readonly><br><br>

                <label for="income-category">카테고리:</label>
                <select id="income-category" name="category" onchange="updateSubcategories('INCOME')">
                    <!-- Category options will be populated dynamically -->
                </select><br><br>

                <label for="income-subcategory">서브카테고리:</label>
                <select id="income-subcategory" name="subCategory">
                    <!-- Subcategory options will be populated based on category selection -->
                </select><br><br>

                <label for="income-source">거래수단: </label>
                <select id="income-source" name="source">
                    <!-- Source options will be populated dynamically -->
                </select><br><br>

                <label for="income-keyword">수입내역:</label>
                <input type="text" id="income-keyword" name="keyword"><br><br>

                <label for="income-amount">수입금액:</label>
                <input type="text" id="income-amount" name="amount"><br><br>

                <label for="income-tag-container">태그:</label>
                <div id="income-tag-container">
                    <!-- Tag buttons will be populated dynamically -->
                </div>
                <input type="hidden" id="income-tags" name="tags"><br><br>

                <div class="form-row">
                    <label for="income-date">날짜: </label>
                    <input type="date" id="income-date" name="date" required>
                    <label for="income-time">시간: </label>
                    <input type="time" id="income-time" name="time" required>
                </div>
                <br>

                <label for="income-rtype">반복주기: </label>
                <select id="income-rtype" name="rtype">
                    <option value="NONE">없음</option>
                    <option value="MONTHLY">월간</option>
                    <option value="WEEKLY">주간</option>
                </select><br><br>

                <label for="income-memo">메모:</label>
                <textarea id="income-memo" name="memo"></textarea><br><br>

                <label for="income-imageUrl">이미지: </label>
                <input type="text" id="income-imageUrl" name="imageUrl"><br><br>

                <input type="submit" value="거래내역 추가">
            </form>
        </div>
    </div>
</div>

</body>
</html>
