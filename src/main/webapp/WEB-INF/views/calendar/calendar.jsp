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
    // calendar.jsp의 모달을 닫는 함수
    function closeModalInCalendar() {
        $('#myModal').hide(); // 모달 숨기기
    }

    $(document).ready(() => {
        const calendarBody = $('#calendar-body');  // 캘린더 본문 요소
        const monthYear = $('#month-year');        // 월과 연도를 표시할 요소
        const prevButton = $('#prev');             // 이전 달 버튼
        const nextButton = $('#next');             // 다음 달 버튼

        const modal = $('#myModal');              // 모달 요소
        const modalContent = $('#modal-body');    // 모달 내용 요소
        const modalDate = $('#modal-date');       // 모달 날짜 요소
        const span = $('.close');                // 모달 닫기 버튼

        let currentDate = new Date();            // 현재 날짜 초기화

        // URL에서 year와 month 파라미터를 가져옴
        const urlParams = new URLSearchParams(window.location.search);
        const yearParam = parseInt(urlParams.get('year'));
        const monthParam = parseInt(urlParams.get('month'));

        // URL 파라미터가 있으면 해당 연도와 월로 currentDate 설정 (year, month)
        if (!isNaN(yearParam) && !isNaN(monthParam)) {
            currentDate = new Date(yearParam, monthParam - 1, 1);
        }

        let dataWithFields = []; // 서버에서 가져온 캘린더 데이터를 저장할 배열
        console.log('첫화면:', dataWithFields);

        // (전) 서버 측에서 초기 데이터를 JSP에서 클라이언트로 전달하는 방식: 먼저 데이터를 뿌려준다
        // (후) 삭제와 수정 이후에, 기존 달력에서 해당 달로 이동하지 않는 오류를 수정하기 위해,
        // AJAX 요청을 통해 서버에서 데이터를 동적으로 가져와서 캘린더를 렌더링하는 방식을 사용함
        // var calendarsJson = ${calendarsJson}; // JSP에서 calendarsJson을 JSON.stringify()로 변환한 값으로 설정해야 함

        // AJAX를 통해 서버에서 달력 데이터를 가져와서 달력을 렌더링하는 함수
        const renderCalendar = (date) => {
            calendarBody.empty(); // 이전 캘린더 데이터 삭제

            const currentYear = date.getFullYear();
            const currentMonth = date.getMonth();
            monthYear.text(date.toLocaleDateString('ko-KR', { month: 'long', year: 'numeric' })); // 월과 연도 텍스트 업데이트

            const firstDay = new Date(currentYear, currentMonth, 1).getDay(); // 이번 달의 첫째 날의 요일 (0은 일요일)
            const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate(); // 이번 달의 총 일수

            let row = $('<tr>'); // 날짜를 표시할 행 생성

            // 첫째 날짜 이전의 빈 셀 추가
            for (let i = 0; i < firstDay; i++) {
                row.append($('<td>'));
            }

            // 각 날짜에 대해 반복
            for (let day = 1; day <= daysInMonth; day++) {
                let cellDate = `${currentYear}-${currentMonth + 1}-${day}`; // 셀의 날짜 문자열
                let cell = $('<td>').text(day).attr('data-date', cellDate); // 날짜와 data-date 속성을 가진 셀 생성

                // 데이터 배열에서 해당 날짜에 데이터가 있는지 확인
                let hasData = dataWithFields.some(item => {
                    let itemDay = new Date(item.time).getDate(); // 데이터의 일 추출
                    return itemDay === day && currentMonth === new Date(item.time).getMonth();
                });

                if (hasData) {
                    cell.addClass('has-data'); // 데이터가 있으면 스타일 클래스 추가
                }

                row.append(cell); // 행에 셀 추가

                if (row.children().length === 7) {
                    calendarBody.append(row); // 행이 가득 차면 달력에 추가
                    row = $('<tr>'); // 새로운 행 생성
                }
            }

            if (row.children().length > 0) {
                calendarBody.append(row); // 남은 마지막 행 추가
            }
        }

        // 기전에는 이전, 다음 달 버튼을 클릭하면 바로 AJAX 요청으로 하였지만 (중복 코드도 해결)
        // 현재는 fetchCalendarData() 함수를 만들어서 캘린더 데이터를 다시 가져오게 함
        // 이전 달 버튼 클릭 처리
        prevButton.on('click', () => {
            currentDate.setMonth(currentDate.getMonth() - 1); // 이전 달로 설정
            renderCalendar(currentDate); // 달력 다시 렌더링
            fetchCalendarData(); // 캘린더 데이터 다시 가져오기
        });

        // 다음 달 버튼 클릭 처리
        nextButton.on('click', () => {
            currentDate.setMonth(currentDate.getMonth() + 1); // 다음 달로 설정
            renderCalendar(currentDate); // 달력 다시 렌더링
            fetchCalendarData(); // 캘린더 데이터 다시 가져오기
        });


        // 날짜 셀 클릭 시 처리
        calendarBody.on('click', 'td', function() {
            const selectedDate = $(this).attr('data-date'); // 선택된 날짜 가져오기
            const cellText = $(this).text(); // 셀에 표시된 텍스트 가져오기
            const monthYearText = monthYear.text(); // 월과 연도 텍스트 가져오기

            // 월과 연도에서 연도와 월 추출
            const year = parseInt(monthYearText.substring(0, 4));
            const month = parseInt(monthYearText.substring(monthYearText.indexOf(' ') + 1, monthYearText.lastIndexOf('월')));

            // 서버로 선택된 날짜 데이터를 전송하여 상세 정보를 가져옵니다.
            $.ajax({
                type: 'GET',
                url: '/calendar/details',
                data: {
                    day: cellText, // 클릭된 날짜 데이터 전송
                    monthYear: monthYearText,
                    backyear: year, // 되돌아오기 위해 연도 정보 추가
                    backmonth: month // 되돌아오기 위해 월 정보 추가
                },
                success: (response) => {
                    modalContent.html(response); // 서버에서 받은 내용을 모달 내용에 삽입
                    modal.show(); // 모달 열기
                },
                error: (error) => {
                    console.error('Error:', error); // 에러 처리
                }
            });
        });

        // 캘린더 데이터를 서버에서 가져오는 함수
        const fetchCalendarData = () => {
            $.ajax({
                type: 'GET',
                url: '/calendar/data',
                data: {
                    year: currentDate.getFullYear(),
                    month: currentDate.getMonth() + 1
                },
                success: (response) => {
                    // 서버에서 받은 데이터를 필요한 형식으로 변환하여 저장
                    dataWithFields = response.map(item => {
                        let date = new Date(item.time);
                        let year = date.getFullYear();
                        let month = ('0' + (date.getMonth() + 1)).slice(-2); // 두 자리 숫자로 포맷
                        let day = ('0' + date.getDate()).slice(-2); // 두 자리 숫자로 포맷
                        let formattedDate = year + '-' + month + '-' + day;

                        return {
                            // 전송 받은 데이터 : {time: "2024-06-05T00:30:00.000+00:00", samount: 5000000, type: "EXPAND"} ...
                            // 변환한 데이터 : {time: "2024-06-05", samount: 5000000, type: "EXPAND"}
                            time: formattedDate,
                            samount: item.samount,
                            type: item.type
                        };
                    });
                    // dataWithFields : 서버에서 받은 내용을 알맞게 변환해서 사용
                    console.log('이동:', dataWithFields);
                    renderCalendar(currentDate); // 달력 다시 렌더링
                },
                error: (error) => {
                    console.error('Error fetching calendar data:', error); // 에러 처리
                }
            });
        };

        // 페이지 로드 시 처음 한 번 데이터 가져오기
        fetchCalendarData();
    });
</script>

</body>
</html>