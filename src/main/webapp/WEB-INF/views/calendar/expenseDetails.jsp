<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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


    <c:forEach var="transaction" items="${calendar}">
        <tr>
            <td><c:out value="${transaction.time}" /></td>
            <td><c:out value="${transaction.time}" /></td>
            <td><c:out value="${transaction.type}" /></td>
            <td><c:out value="${transaction.keyword}" /></td>
            <td><c:out value="${transaction.samount}" /></td>
            <td><c:out value="${transaction.installment != 1 ? '예' : '아니오'}" /></td>
            <td>
                <form action="/calendar/updateTransaction" method="post">
                    <input type="hidden" name="transactionId" value="${transaction.tno}" />
                    <button type="submit">수정</button>
                </form>
            </td>
            <td>
                <form action="/calendar/deleteTransaction" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                    <input type="hidden" name="transactionId" value="${transaction.tno}" />
                    <input type="hidden" name="backyear" value="${backyear}" /> <!-- 삭제 후에도 year 유지 -->
                    <input type="hidden" name="backmonth" value="${backmonth}" /> <!-- 삭제 후에도 month 유지 -->
                    <button type="submit">삭제</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<script>
    // // expenseDetails.jsp에서의 AJAX 요청 및 처리
    // $(document).ready(function() {
    //     // 모달 내의 삭제 버튼 클릭 이벤트 처리
    //     $('#modal').on('click', '.delete-btn', function(event) {
    //
    //         console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    //         event.preventDefault(); // 기본 동작 방지
    //
    //         var form = $(this).closest('form');
    //
    //         $.ajax({
    //             type: form.attr('method'),
    //             url: form.attr('action'),
    //             data: form.serialize(),
    //             success: function(response) {
    //                 console.log("삭제 성공");
    //                 // closeModal(); // 모달 닫기
    //                 closeModal(); // 모달 닫기
    //                 // 삭제 후에 달력 페이지를 다시 로드
    //                 var backyear = form.find('input[name="backyear"]').val();
    //                 var backmonth = form.find('input[name="backmonth"]').val();
    //                 loadCalendarPage(backyear, backmonth);
    //             },
    //             error: function(error) {
    //                 console.error('Error:', error);
    //                 // 에러 처리
    //             }
    //         });
    //     });
    //
    //     // 모달을 닫는 함수
    //     function closeModal() {
    //         $('#modal').hide();
    //     }
    //
    //     // 달력 페이지를 로드하는 함수
    //     function loadCalendarPage(year, month) {
    //         $.ajax({
    //             type: 'GET',
    //             url: '/calendar/data',
    //             data: {
    //                 year: year,
    //                 month: month
    //             },
    //             success: function(calendars) {
    //                 $('#calendar-container').html(calendars); // 달력 페이지 업데이트
    //             },
    //             error: function(error) {
    //                 console.error('Error:', error);
    //                 // 에러 처리
    //             }
    //         });
    //     }
    // });

</script>