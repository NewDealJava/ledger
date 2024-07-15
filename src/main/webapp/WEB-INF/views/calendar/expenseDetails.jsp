<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
                    <button onclick="openUpdateForm(${transaction.tno}, '${transaction.keyword}', ${transaction.samount})">수정</button>
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

<!-- 수정 폼 모달 -->
<div id="updateFormModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <form id="updateForm" method="post">
            <input type="hidden" id="updateTno" name="tno" />
            <input type="text" id="newKeyword" name="newKeyword" placeholder="새 키워드 입력" required />
            <input type="number" id="newAmount" name="newAmount" placeholder="새 금액 입력" required />
            <button type="submit">수정</button>
        </form>
    </div>
</div>

<%--<script src="/js/calendar.js"></script>--%>

<script>
    // 모달 내에서 "수정" 버튼을 클릭하여 수정 작업을 완료한 후,
    // 모달을 닫고 현재 페이지(모달을 열었던 페이지)도 닫히도록 하려면, 두 단계로 진행
    // 1. 수정 폼 모달 닫기: 수정 작업 완료 후 현재 열려있는 모달을 닫기
    // 2. 현재 페이지 닫기: 모달을 열었던 부모 페이지도 닫기

    $(document).ready(function() {
        const modal = $('#updateFormModal');  // 모달 요소 가져오기
        const closeButton = $('.close');  // 모달 닫기 버튼 가져오기

        // X 버튼 클릭 이벤트 처리
        closeButton.click(function() {
            closeModal(); // 로컬 모달 닫기 함수 호출
        });

        // 모달 외부 클릭 시 닫기 처리
        $(document).on('click', function(event) {
            if ($(event.target).is('#updateFormModal')) {
                closeModal(); // 로컬 모달 닫기 함수 호출
            }
        });

        // 모달을 닫는 함수
        function closeModal() {
            modal.hide(); // 로컬 모달 숨기기
        }

        // 수정 폼 열기
        window.openUpdateForm = function(tno, keyword, samount) {
            $('#updateTno').val(tno);
            $('#newKeyword').val(keyword);
            $('#newAmount').val(samount);
            modal.show();
        };

        // 수정 폼 제출 처리
        $('#updateForm').submit(function(event) {
            event.preventDefault();
            var form = $(this);

            $.ajax({
                type: form.attr('method'),
                url: '${pageContext.request.contextPath}/calendar/updateTransaction',
                data: form.serialize(),
                success: function(response) {
                    console.log(response);
                    closeModal();
                    // 성공 시 화면 갱신 로직 추가
                },
                error: function(error) {
                    console.error('Error:', error);
                    // 에러 처리
                }
            });
        });

        // 모달 내의 삭제 버튼 클릭 이벤트 처리
        $('#modal').on('click', '.delete-btn', function(event) {
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
                success: function(response) {
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
                error: function(error) {
                    console.error('Error:', error);
                    // 에러 처리
                    // hideLoadingIndicator(); // 에러 발생 시에도 로딩 인디케이터 숨기기
                }
            });
        });

    });
</script>