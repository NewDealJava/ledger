<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendar</title>
    <!-- 분리 예정 -->
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .calendar-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            margin-top: 50px;
        }
        .calendar {
            display: table;
            border-collapse: collapse;
            width: 100%;
            max-width: 600px;
            margin: 20px auto;
        }
        .calendar th, .calendar td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        .calendar th {
            background-color: #f2f2f2;
        }
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .calendar-header button {
            padding: 10px;
            cursor: pointer;
        }

        /* 모달 스타일 추가 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
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

        /* 날짜 셀의 배경색을 설정하는 클래스 */
        .calendar th, .calendar td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            position: relative; /* 상대적 배치 적용 */
        }

        .has-data {
            position: relative; /* 상대적 배치 적용 */
        }

        .has-data::before {
            content: '';
            position: absolute;
            left: 50%; /* 박스 위치를 조정 */
            top: 50%;
            transform: translate(200%, -50%); /* x,y순 */
            width: 10px; /* 박스 크기 */
            height: 10px;
            background-color: #d4edda; /* 초록색 배경 */
            border-radius: 50%; /* 둥근 모양 */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- jsp:include page="../views/incl/header_on.jsp" flush="true" / -->


<!-- 모달 창 구조 추가 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2 id="modal-date"></h2>
        <div id="modal-body">

        </div>
    </div>
</div>


<main>
    <section id="calendar">
        <div class="calendar-container">
            <div class="calendar-header">
                <button id="prev">Prev</button>
                <h2 id="month-year"></h2>
                <button id="next">Next</button>
            </div>
            <table class="calendar">
                <thead>
                <colgroup>
                    <col width="14%"/>
                    <col width="14%"/>
                    <col width="14%"/>
                    <col width="14%"/>
                    <col width="14%"/>
                    <col width="14%"/>
                    <col width="14%"/>
                </colgroup>
                <tr>
                    <th>Sun</th>
                    <th>Mon</th>
                    <th>Tue</th>
                    <th>Wed</th>
                    <th>Thu</th>
                    <th>Fri</th>
                    <th>Sat</th>
                </tr>
                </thead>
                <!-- 내부에는 실제 달력 내용이 js에서 동적으로 생성된다 -->
                <tbody id="calendar-body">
                <rowgroup>
                    <row width="14%"/>
                    <row width="14%"/>
                    <row width="14%"/>
                    <row width="14%"/>
                    <row width="14%"/>
                    <row width="14%"/>
                    <row width="14%"/>
                </rowgroup>
                </tbody>
            </table>
        </div>
    </section>
</main>
<!-- jsp:include page="../views/incl/footer.jsp" flush="true" / -->
<script>
    $(document).ready(() => {
        const calendarBody = $('#calendar-body');
        const monthYear = $('#month-year');
        const prevButton = $('#prev');
        const nextButton = $('#next');

        // 모달 창
        const modal = $('#myModal');
        const modalContent = $('#modal-body'); // 수정된 부분
        const modalDate = $('#modal-date');
        const span = $('.close');

        let currentDate = new Date();
        let dataWithFields = []; // 서버에서 받아올 데이터를 저장할 배열

        var calendarsJson = ${calendarsJson}; // JSP에서 calendarsJson을 JSON.stringify()로 변환한 값으로 설정해야 함

        // calendarsJson 배열에서 각 객체의 date, amount, recordType 필드 값들을 추출하여 새로운 배열을 만듭니다.
        dataWithFields = calendarsJson.map(function(item) {
            // 자바스크립트에서 날짜 형식으로 변환
            var date = new Date(item.time);
            var year = date.getFullYear();
            var month = ('0' + (date.getMonth() + 1)).slice(-2); // 두 자리 숫자로 포맷
            var day = ('0' + date.getDate()).slice(-2); // 두 자리 숫자로 포맷
            var formattedDate = year + '-' + month + '-' + day;

            return {
                // 기존 : {date: '2024-07-01', amount: 20, recordType: 'Expense'} ...
                // date: item.date,
                // amount: item.amount,
                // recordType: item.recordType

                // 서버에서 받아온 데이터는 JSON 형태로, 날짜는 밀리초 단위의 타임스탬프로 제공됨
                // JSON 데이터 : {time: 1720580327000, samount: 5000000, type: "EXPAND"} ...
                // 타임스탬프를 사람이 읽을 수 있는 형식으로 변환 : {time: "2024-07-10", samount: 5000000, type: "EXPAND"} ...
                time: formattedDate,
                samount: item.samount,
                type: item.type
            };
        });
        // Processed data array : 주로 클라이언트 측에서 서버로부터 받은 데이터를 필요한 형태로 가공하여 사용할 때
        console.log('첫화면:', dataWithFields);

        // *** 캘린더 렌더링 함수
        let renderCalendar = (date) => {
            // console.log(date); // Mon Jul 08 2024 16:08:12 GMT+0900 (한국 표준시)
            calendarBody.empty();
            const currentYear = date.getFullYear();
            // console.log(currentYear); // 2024
            const currentMonth = date.getMonth();
            // console.log(currentMonth); // 6
            monthYear.text(date.toLocaleDateString('ko-KR', { month: 'long', year: 'numeric' }));
            // console.log(monthYear.text()); // 이동할 때 마다 년월이 콘솔창에 출력이 된다 -> ***예시)2024년 7월
            const firstDay = new Date(currentYear, currentMonth, 1).getDay(); // 시작일 수 건너 뛴 수 -> 1...
            const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate(); // 마지막일 수 -> 31...

            let row = $('<tr>'); // 첫행
            for (let i = 0; i < firstDay; i++) {
                row.append($('<td>'));
            }
            // 예시: dataWithFields 배열에서 time 필드의 값들을 출력
            // dataWithFields.forEach(item => {
            //     console.log(item.time); // 각 객체의 time 필드 값 출력
            // });
            // 결론 dataWithFields = date:"2024-07-01" 여기에서 textContent=1 day가 동일해야 한다
            for (let day = 1; day <= daysInMonth; day++) {
                let cellDate = `${currentYear}-${currentMonth + 1}-${day}`; // 현재 셀의 날짜 문자열
                let cell = $('<td>').text(day).attr('data-date', cellDate);
                // console.log(cell.text()); // outerText 출력 -> 1,2,3...

                // td에 있는 outerText와 dataWithFields에 있는 date:"2024-07-01"에 있는 1이 같으면 스타일 적용하도록 if문 작성
                // 현재 셀의 텍스트(일)와 dataWithFields의 날짜 부분을 비교
                let hasData = dataWithFields.some(item => {
                    let itemDay = new Date(item.time).getDate(); // item.date에서 날짜 부분만 추출
                    return itemDay === day;
                });
                // console.log(hasData); // 값을 비교해서 true 또는 false
                if (hasData) {
                    cell.addClass('has-data'); // 스타일 클래스 추가
                }
                row.append(cell);
                if (row.children().length === 7) {
                    calendarBody.append(row);
                    row = $('<tr>');
                }
            }
            if (row.children().length > 0) {
                calendarBody.append(row);
            }
        }

        // *** 뒤로 가기 버튼
        prevButton.on('click', () => {
            currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar(currentDate);
            // AJAX 요청 추가
            $.ajax({
                type: 'GET',
                url: '/calendar/data',
                data: {
                    year: currentDate.getFullYear(),
                    month: currentDate.getMonth() + 1
                },
                success: function (response) {
                    // 데이터 배열로 변환: date, amount, recordType 필드만 포함
                    dataWithFields = response.map(function(item) {
                        // 자바스크립트에서 날짜 형식으로 변환
                        var date = new Date(item.time);
                        var year = date.getFullYear();
                        var month = ('0' + (date.getMonth() + 1)).slice(-2); // 두 자리 숫자로 포맷
                        var day = ('0' + date.getDate()).slice(-2); // 두 자리 숫자로 포맷
                        var formattedDate = year + '-' + month + '-' + day;
                        // console.log(formattedDate); // 2024-06-05 ...

                        return {
                            // 전송 받은 데이터 : {time: "2024-06-05T00:30:00.000+00:00", samount: 5000000, type: "EXPAND"} ...
                            // 변환한 데이터 : {time: "2024-06-05", samount: 5000000, type: "EXPAND"}
                            time: formattedDate,
                            samount: item.samount,
                            type: item.type
                        };
                    });
                    // Data with fields : 버에서 받은 원본 데이터를 그대로 사용할 때 유용
                    console.log('이동:', dataWithFields);
                    renderCalendar(currentDate); // 캘린더를 다시 렌더링
                },
                error: function (error) {
                    console.error('Error fetching calendar data:', error);
                }
            });
        });

        // *** 앞으로 가기
        nextButton.on('click', () => {
            currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar(currentDate);

            // AJAX 요청 추가
            $.ajax({
                type: 'GET',
                url: '/calendar/data',
                data: {
                    year: currentDate.getFullYear(),
                    month: currentDate.getMonth() + 1
                },
                success: function (response) {
                    dataWithFields = response.map(function(item) {
                        // 자바스크립트에서 날짜 형식으로 변환
                        var date = new Date(item.time);
                        var year = date.getFullYear();
                        var month = ('0' + (date.getMonth() + 1)).slice(-2); // 두 자리 숫자로 포맷
                        var day = ('0' + date.getDate()).slice(-2); // 두 자리 숫자로 포맷
                        var formattedDate = year + '-' + month + '-' + day;
                        // console.log(formattedDate); // 2024-06-05 ...

                        return {
                            time: formattedDate,
                            samount: item.samount,
                            type: item.type
                        };
                    });
                    console.log('이동:', dataWithFields);
                    renderCalendar(currentDate); // 캘린더를 다시 렌더링
                },
                error: function (error) {
                    console.error('Error fetching calendar data:', error);
                }
            });
        });

        // *** 날짜 셀 클릭 이벤트 처리
        calendarBody.on('click', 'td', function() {
            const selectedDate = $(this).attr('data-date');
            // console.log($(this).text()); // 클릭된 셀의 텍스트 출력
            const cellText = $(this).text();
            // console.log(cellText); // 4
            const monthYearText = monthYear.text();
            // console.log(monthYearText); // 2024년 7월

            // monthYearText에서 연도와 월 추출
            const year = parseInt(monthYearText.substring(0, 4));
            // console.log(year); // 2024
            const month = parseInt(monthYearText.substring(monthYearText.indexOf(' ') + 1, monthYearText.lastIndexOf('월')));
            // console.log(month); // 6

            $.ajax({
                type: 'GET',
                url: '/calendar/details',
                data: {
                    day: cellText, // 클릭된 날짜의 데이터를 전송
                    monthYear: monthYearText,
                    backyear: year, // 연도 정보 추가 (삭제 후에 돌아오기 위해서)
                    backmonth: month // 월 정보 추가 ...
                },
                success: (response) => {
                    // 모달 열기 이벤트: 서버에서 받은 데이터를 모달에 표시하고 모달을 연다.
                    modalContent.html(response); // 서버에서 받은 내용을 모달 창에 삽입
                    modal.show();
                },
                error: (error) => {
                    console.error('Error:', error);
                    // 에러 발생 시 처리
                }
            });
        });

        // 모달 닫기 이벤트
        span.on('click', () => {
            modal.hide();
        });

        // 모달 닫기 이벤트: 모달 외부 클릭 시 모달 닫기
        $(window).on('click', (e) => {
            if ($(e.target).is(modal)) {
                modal.hide();
            }
        });

        renderCalendar(currentDate);
    });
</script>



</body>
</html>
