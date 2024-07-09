<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>가게부</title>
  </head>
  <!-- ♣♣♣ CSS ♣♣♣ -->
  <link href="../css/inquiry.css?ver=1" rel="stylesheet" />

  <!-- JQuery 최신 -->
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>

  <!--◁◀◁◀ Header ▶▷▶▷ -->
  <%@ include file="/WEB-INF/views/include/header.jsp"%>
  <!--◁◀◁◀ Header ▶▷▶▷ -->

  <script>
    $(function () {
      $("#searchBtn").click(function () {
        if ($("#searchWord").val().length < 1) {
          alert("※ 검색어를 입력해주세요.");
          $("#searchWord").focus();
          return false;
        } //if(검색어 미입력시)

        SearchFrm.submit();
      }); //#searchBtn(검색어)

      //검색어 유지
      var SearchWord_Maintain = $("#searchWord_maintain").val();
      $("#searchWord").val(SearchWord_Maintain);
    }); //제이쿼리 최신
  </script>
  <body>
    <div class="board-title-container">
        <div class="board-title-area">
          <h1 class="board-title">문의게시판</h1>
        </div>
        <div class="board-container">
          <div class="filter-answer-status-area">
            <div></div>
            <select class="filter-answer-select">
              <option value="all" selected="selected">전체</option>
              <option value="waiting">답변대기</option>
              <option value="finish">답변완료</option>
            </select>
          </div>
          <div class="qna-board-list-area">
            <table>
              <thead>
                <tr class="qna-board-list-head">
                  <th class="qna-board-list-uid">번호</th>
                  <th class="qna-board-list-title">제목</th>
                  <th class="qna-board-list-user">작성자</th>
                  <th class="qna-board-list-date">작성일</th>
                  <th class="qna-board-list-status">문의상태</th>
                  <th class="qna-board-list-view">조회</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach var="ibdto" items="${map.list}">
                    <tr class="qna-board-list-body">
                      <td class="qna-board-list-uid">${ibdto.qbno}</td>
                      <td class="qna-board-list-title">
                        <a href="">
                          <div class="default-cut-strings">${ibdto.qtitle}</div>
                        </a>
                      </td>
                      <td class="qna-board-list-user">${ibdto.email}</td>
                      <td class="qna-board-list-date"><fmt:formatDate value="${ibdto.qdate}" pattern="YYYY-MM-dd"/></td>
                      <td class="qna-board-list-status">
                       <c:if test="${ibdto.qstatus<=0}"><strong style="color : red;">답변대기</strong></c:if>
                       <c:if test="${ibdto.qstatus>0}"><strong style="color : blue;">답변완료</strong></c:if>
                      </td>
                      <td class="qna-board-list-view">0</td>
                    </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <div class="pagination-area">
            <ul id="pagination">
              <!--첫번째 페이지-->
              <li class="pagination-first-page"><a href="#">처음</a></li>
              <!--이전 페이지-->
              <li class="pagination-prev-page">
                <a href="#"><</a></i>
              </li>

              <!--페이지 넘버링-->
              <c:forEach var="i" begin="${map.startPageNum}" end="${map.endPageNum }" step="1">
                <li class="pagination-number"><a href="#">${i}</a></li>
              </c:forEach>
              <!--페이지 넘버링-->

              <!--다음 페이지-->
              <li class="pagination-next-page">
                <a href="#">></a>
              </li>
              <!-- 마지막 페이지 -->
              <li class="pagination-last-page">
                <a href="#">마지막</a>
              </li>
            </ul>
          </div>
          <div class="search-area">
            <select class="search-word-select">
              <option value="All" selected="selected">전체</option>
              <option value="qtitle">제목</option>
              <option value="qcontent">내용</option>
              <option value="Id">아이디</option>
            </select>
            <input
              type="text"
              class="search-word-input"
              id="searchWord"
              name="searchWord"
            />
            <button id="searchBtn" class="search-word-button">검색</button>
          </div>
          <div class="control-area">
            <a href="#">글쓰기</a>
          </div>
        </div>
      </div>
  </body>

  <!--◁◀◁◀ Footer ▶▷▶▷ -->
  <%-- <%@ include file="/WEB-INF/views/include/footer.jsp"%> --%>
  <!--◁◀◁◀ Footer ▶▷▶▷ -->
</html>
