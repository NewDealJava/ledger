<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 지출, 수입 추가 버튼 -->
<div class="container">
    <!-- Trigger/Open The Modal -->
    <button id="openModalButton" class="open-modal-button">+</button>
</div>

<div id="content">
    <h2>
        <c:choose>
            <c:when test="${not empty calendar and calendar[0].type == 'Expense'}">
                지출 내역
            </c:when>
            <c:when test="${not empty calendar and calendar[0].type == 'Income'}">
                수입 내역
            </c:when>
            <c:otherwise>
                기타
            </c:otherwise>
        </c:choose>
    </h2>

    <table>
        <thead>
        <tr>
            <th>날짜</th>
            <th>시간</th>
            <th>분류</th>
            <th>키워드</th>
            <th>금액</th>
            <th>할부</th>
            <th>수정</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="transaction" items="${calendars}">
            <tr>
                <td><c:out value="${transaction.time}" /></td>
                <td><c:out value="${transaction.time}" /></td>
                <td><c:out value="${transaction.type}" /></td>
                <td><c:out value="${transaction.keyword}" /></td>
                <td><c:out value="${transaction.samount}" /></td>
                <td><c:out value="${transaction.installment != 1 ? '예' : '아니오'}" /></td>
                <td>
                    <button onclick="openCustomModal(${transaction.tno}, '${transaction.type}')">수정</button>
                </td>
                <td>
                    <form action="/calendar/deleteTransaction" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                        <input type="hidden" name="tno" value="${transaction.tno}" />
                        <input type="hidden" name="backyear" value="${backyear}" />
                        <input type="hidden" name="backmonth" value="${backmonth}" />
                        <button type="submit">삭제</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- The Modal -->
<div id="expenseIncomeModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">
        <span class="close">&times;</span>

        <!-- Tab links -->
        <div class="tab">
            <!-- 초기 탭 지출 -->
            <button id="defaultOpen" class="tablinks" onclick="openTab(event, 'Expense')">지출</button>
            <button class="tablinks" onclick="openTab(event, 'Income')">수입</button>
        </div>

        <!-- Tab content -->
        <div id="Expense" class="tab-content">
            <form id="expense-form" onsubmit="submitExpenseForm(event)">
                <h3>지출</h3>

                <label for="expense-type">타입:</label>
                <input type="text" id="expense-type" name="type" value="EXPENSE" readonly><br><br>

                <label for="expense-category">카테고리:</label>
                <select id="expense-category" name="category" onchange="updateSubcategories('EXPENSE')">
                    <!-- Category options will be populated dynamically -->
                </select><br><br>

                <label for="expense-subcategory">세부카테고리:</label>
                <select id="expense-subcategory" name="subcategory">
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
                    <option value="일시불">일시불</option>
                    <% for (int i = 2; i <= 36; i++) { %>
                    <option value="<%= i %>개월"><%= i %>개월</option>
                    <% } %>
                </select><br><br>

                <label for="expense-tag-container">태그: </label>
                <div id="expense-tag-container">
                    <!-- Tag buttons will be populated dynamically -->
                </div>
                <input type="hidden" id="expense-tags" name="tags"><br><br>

                <div class="form-row">
                    <label for="expense-date">날짜: </label>
                    <input type="date" id="expense-date" name="date" required>
                    <label for="expense-time">시간: </label>
                    <input type="time" id="expense-time" name="time" required>
                </div><br>

                <label for="expense-rtype">반복주기: </label>
                <select id="expense-rtype" name="rtype">
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

                <label for="income-type">타입:</label>
                <input type="text" id="income-type" name="type" value="INCOME" readonly><br><br>

                <label for="income-category">카테고리:</label>
                <select id="income-category" name="category" onchange="updateSubcategories('INCOME')">
                    <!-- Category options will be populated dynamically -->
                </select><br><br>

                <label for="income-subcategory">서브카테고리:</label>
                <select id="income-subcategory" name="subcategory">
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
                </div><br>

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


<%--<script src="/js/calendar.js"></script>--%>

<script>

    // **수정 버튼 클릭 시 모달 열기 함수
    function openCustomModal(tno, type) {
        console.log(tno); // 1891
        console.log(type); // EXPAND
        const modal = document.getElementById("expenseIncomeModal");

        // AJAX 요청 설정
        $.ajax({
            type: "GET",
            url: `/calendar/getTransactionDetails/${tno}`, // tno를 URL에 포함하여 전달
            success: function(data) {
                console.log('Transaction details:', data);

                // 데이터가 null인 경우 처리
                if (!data) {
                    console.error('Transaction details not found');
                    return;
                }

                // EXPAND(지출)인 경우
                if (type === 'EXPAND') {
                }
                // INCOME(수입)인 경우
                else if (type === 'INCOME') {
                }

                // 모달을 보이도록 설정
                modal.style.display = "block";
            },
            error: function(error) {
                console.error('Error fetching transaction details:', error);
                // 에러 발생 시 예외 처리
                alert('Error fetching transaction details');
            }
        });

        // 모달 닫기 버튼 설정
        const span = document.getElementsByClassName("close")[0];
        span.onclick = function() {
            modal.style.display = "none";
        };

        // 모달 외부 클릭 시 닫기 설정
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        };
    }

    // 거래수단 로드
    function loadSources(type) {
        const sourceSelect = type === 'EXPENSE' ? document.getElementById("expense-source") : document.getElementById("income-source");

        $.ajax({
            url: '/api/transaction/source', // 주어진 이메일에 대해 'ACCOUNT'와 'CARD' 소스의 타입과 하위 타입을 결합하여 반환하는 SQL 쿼리 반환
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                data.forEach(function(source) {
                    const option = document.createElement("option");
                    option.value = source.sourceType + ' - ' + source.sno;
                    option.text = source.sourceType + ' - ' + source.subSourceType + ' - ' + source.cname;
                    sourceSelect.add(option);
                });

            },
            error: function(error) {
                console.error('Error loading sources:', error);
            }
        });
    }

    // 초기에 기본 탭을 표시할 경우 아래 코드를 사용할 수 있습니다 (선택사항)
    document.addEventListener('DOMContentLoaded', (event) => {
        // document.getElementById("defaultOpen").click(); // 지출 버튼

        var modal = document.getElementById("expenseIncomeModal");  // 모달 요소 가져오기
        var btn = document.getElementById("openModalButton");  // 모달 여는 버튼
        var span = document.getElementsByClassName("close")[0];

        btn.onclick = function() {
            modal.style.display = "block";
            openTab(event, 'Expense');
        }

        span.onclick = function() {
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

    });

    // 지출과 수입 탭을 전환하는 함수
    function openTab(event, tabName) {
        var i, tabcontent, tablinks;

        // 모든 탭 컨텐츠를 숨깁니다.
        tabcontent = document.getElementsByClassName("tab-content");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }

        // 모든 탭 링크를 비활성화합니다.
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }

        // 선택한 탭 컨텐츠를 표시하고, 버튼을 활성화 상태로 만듭니다.
        document.getElementById(tabName).style.display = "block";
        event.currentTarget.className += " active";
    }

    // 카테고리 로드
    function loadCategories(type) {
        const categorySelect = type === 'EXPENSE' ? document.getElementById("expense-category") : document.getElementById("income-category");

        $.ajax({
            url: '/api/category', // category 테이블, type = EXPENSE
            method: 'GET',
            data: { type: type },
            dataType: 'json',
            success: function(data) {
                data.forEach(function(category) {
                    const option = document.createElement("option");
                    option.value = category.cno;
                    option.text = category.name;
                    categorySelect.add(option);
                });

                // 서브카테고리 업데이트
                updateSubcategories(type);
            },
            error: function(error) {
                console.error('Error loading categories:', error);
            }
        });
    }

    // 매개변수 type에 따라 카테고리와 서브카테고리 선택
    function updateSubcategories(type) {
        const categorySelect = type === 'EXPENSE' ? document.getElementById("expense-category") : document.getElementById("income-category");
        //console.log(categorySelect); // 카테고리(지출과 수입 동시에 가져옴)
        const subcategorySelect = type === 'EXPENSE' ? document.getElementById("expense-subcategory") : document.getElementById("income-subcategory");
        //console.log(subcategorySelect); // 세부 카테고리(지출과 수입 동시에 가져옴)
        // 선택된 카테고리 값 가져오기
        const selectedCategory = categorySelect.value;

        subcategorySelect.innerHTML = "";
        // AJAX 요청을 통한 서브카테고리 업데이트
        $.ajax({
            url: '/api/category/subcategory',
            method: 'GET',
            data: {parentCno: selectedCategory},
            dataType: 'json',
            success: function (data) {
                // cno: 25, type: 'EXPENSE', name: '고기', parentCno: 1...
                // cno: 147, type: 'INCOME', name: '기타', parentCno: 20
                // console.log(data);

                // 성공적으로 데이터를 받아온 경우
                data.forEach(function (subcategory) {
                    // 각 서브카테고리 옵션을 생성하여 서브카테고리 선택 요소에 추가
                    const option = document.createElement("option");
                    option.value = subcategory.cno;
                    option.text = subcategory.name;
                    subcategorySelect.add(option);
                });
            },
            error: function (error) {
                // 오류가 발생한 경우
                console.error('Error loading subcategories:', error);
            }
        });
    }

    // 태그 로드
    function loadTags(type) {
        const tagContainer = type === 'EXPENSE' ? document.getElementById("expense-tag-container") : document.getElementById("income-tag-container");
        const hiddenInput = type === 'EXPENSE' ? document.getElementById("expense-tags") : document.getElementById("income-tags");

        $.ajax({
            url: '/api/tag', // tag 테이블, email = user1@example.com
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                data.forEach(function(tag) {
                    const button = document.createElement("button");
                    button.type = "button";
                    button.className = "tag-button";
                    button.textContent = tag.name;
                    button.dataset.tagId = tag.tno;
                    button.onclick = function() {
                        this.classList.toggle("selected");
                        updateSelectedTags(hiddenInput, tagContainer);
                    };
                    tagContainer.appendChild(button);
                });
            },
            error: function(error) {
                console.error('Error loading tags:', error);
            }
        });
    }

    /**
     * 지출 폼 제출 처리 함수
     * @param {Event} event - 폼 제출 이벤트
     */
    function submitExpenseForm(event) {
        console.log(확인);
        event.preventDefault(); // 폼의 기본 제출 동작을 막음
        const form = document.getElementById("expense-form");
        const formData = new FormData(form); // 폼 데이터를 FormData 객체로 가져옴
        const jsonObject = {};

        // 'source' 필드를 분할하여 sourceType과 sno로 저장
        let sourceData = formData.get('source').split(' - ');
        jsonObject['sourceType'] = sourceData[0];
        jsonObject['sno'] = sourceData[1];

        // 'installment' 값을 처리하여 jsonObject에 추가
        let installmentValue = formData.get('installment');
        if (installmentValue === '일시불') {
            jsonObject['installment'] = 1; // 일시불은 1로 저장
        } else {
            jsonObject['installment'] = parseInt(installmentValue.replace('개월', '')); // '개월'을 제거하고 숫자로 변환하여 저장
        }

        // 'rtype' 값을 jsonObject에 추가
        let rtypeValue = formData.get('rtype');
        jsonObject['rtype'] = rtypeValue;

        // formData의 각 항목을 순회하여 jsonObject에 추가
        formData.forEach((value, key) => {
            if (key !== 'installment' && key !== 'rtype' && key !== 'source') {
                jsonObject[key] = value;
            }
        });

        // 서버에 POST 요청을 보내 거래내역 추가
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
                resetFormAndCloseModal('expense-form'); // 성공 시 폼을 리셋하고 모달을 닫음
            })
            .catch(error => {
                console.error('Error:', error); // 오류 처리
            });
    }

    /**
     * 수입 폼 제출 처리 함수
     * @param {Event} event - 폼 제출 이벤트
     */
    function submitIncomeForm(event) {
        event.preventDefault(); // 폼의 기본 제출 동작을 막음
        const form = document.getElementById("income-form");
        const formData = new FormData(form); // 폼 데이터를 FormData 객체로 가져옴
        const jsonObject = {};

        // 'source' 필드를 분할하여 sourceType과 sno로 저장
        let sourceData = formData.get('source').split(' - ');
        jsonObject['sourceType'] = sourceData[0];
        jsonObject['sno'] = sourceData[1];

        // 'rtype' 값을 jsonObject에 추가
        let rtypeValue = formData.get('rtype');
        jsonObject['rtype'] = rtypeValue;

        // formData의 각 항목을 순회하여 jsonObject에 추가
        formData.forEach((value, key) => {
            if (key !== 'rtype' && key !== 'source') {
                jsonObject[key] = value;
            }
        });

        // 서버에 POST 요청을 보내 거래내역 추가
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
                resetFormAndCloseModal('income-form'); // 성공 시 폼을 리셋하고 모달을 닫음
            })
            .catch(error => {
                console.error('Error:', error); // 오류 처리
            });
    }

    // 위에 코드는 createTransactionModel.jsp 코드와 동일하게 적용

    // 모달 내에서 "수정" 버튼을 클릭하여 수정 작업을 완료한 후,
    // 모달을 닫고 현재 페이지(모달을 열었던 페이지)도 닫히도록 하려면, 두 단계로 진행
    // 1. 수정 폼 모달 닫기: 수정 작업 완료 후 현재 열려있는 모달을 닫기
    // 2. 현재 페이지 닫기: 모달을 열었던 부모 페이지도 닫기

    $(document).ready(function() {
        const modal = $('#expenseIncomeModal');  // 모달 요소 가져오기
        const closeButton = $('.close');  // 모달 닫기 버튼 가져오기

        // X 버튼 클릭 이벤트 처리
        closeButton.click(function () {
            closeModal(); // 로컬 모달 닫기 함수 호출
        });

        // 모달 외부 클릭 시 닫기 처리
        $(document).on('click', function (event) {
            if ($(event.target).is('#expenseIncomeModal')) {
                closeModal(); // 로컬 모달 닫기 함수 호출
            }
        });

        // 모달을 닫는 함수
        function closeModal() {
            modal.hide(); // 로컬 모달 숨기기
        }

        // 버튼 클릭 시 지출 수입 폼 모달 열기
        $('#openModalButton').click(function() {
            openExpenseIncomeModal();
        });

        window.openExpenseIncomeModal = function () {
            $('#expenseIncomeModal').show(); // 지출, 수입 폼 모달 열기

            // 모달이 열릴 때 지출 탭을 기본으로 설정
            document.getElementById("defaultOpen").click(); // 지출 탭을 기본으로 설정

            // ***카테고리, 태그, 거래수단 로드 -> 코드 블록은 페이지가 로딩되면 자동으로 실행
            loadCategories('EXPENSE');
            loadCategories('INCOME');
            loadTags('EXPENSE');
            loadTags('INCOME');
            loadSources('EXPENSE');
            loadSources('INCOME');
        };

        // 모달 내의 삭제 버튼 클릭 이벤트 처리
        $('#modal').on('click', '.delete-btn', function (event) {
            event.preventDefault(); // 기본 동작 방지

            var form = $(this).closest('form');

            $.ajax({
                type: form.attr('method'),
                // url: form.attr('action'),
                url: '/calendar/deleteTransaction', // 삭제 트랜잭션 처리하는 URL
                // data: form.serialize(),
                data: {
                    tno: form.find('input[name="tno"]').val(),
                    backyear: form.find('input[name="backyear"]').val(),
                    backmonth: form.find('input[name="backmonth"]').val()
                },
                success: function (response) {
                    console.log(response);
                    closeModal(); // 모달 닫기
                    // 삭제 후에 달력 페이지를 다시 로드 -> 삭제후에 calendar메서드를 알맞게 사용하기 위해
                    // 성공 콜백에서 달력 페이지로 리다이렉트
                    var backyear = form.find('input[name="backyear"]').val();
                    var backmonth = form.find('input[name="backmonth"]').val();

                    // 비동기 처리 문제 발생 : 응답이 왔을 때 UI가 이미 변경된 상태
                    // 해결 방안 : 데이터를 적절히 처리하고 업데이트하는 코드를 작성
                    // 성공 콜백에서 UI 업데이트
                    // loadCalendarPage(response);
                },
                error: function (error) {
                    console.error('Error:', error);
                    // 에러 처리
                    // hideLoadingIndicator(); // 에러 발생 시에도 로딩 인디케이터 숨기기
                }
            });
        });

    });
</script>