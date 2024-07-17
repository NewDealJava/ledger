<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>YOONICORN 가계부</title>
  </head>
  <!-- ♣♣♣ CSS ♣♣♣ -->
  <link href="../css/inquiry.css?ver=1" rel="stylesheet" />
  <!-- ♣♣♣ font ♣♣♣ -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

  <!-- JQuery 최신 -->
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>

  <!--◁◀◁◀ Header ▶▷▶▷ -->
  <%@ include file="/WEB-INF/views/include/header.jsp"%>
  <!--◁◀◁◀ Header ▶▷▶▷ -->

  <script>
    $(function () {
     //검색어 유지
      var search_main=$("#SearchWord_hidden").val(); //검색창 검색어 유지기능
      $("#SearchWord").val(search_main); //검색어 유지 및 검색어 보여지는 갯수 유지

      $("#searchBtn").click(function () {
        if ($("#SearchWord").val().length < 1) {
          alert("※ 검색어를 입력해주세요.");
          $("#SearchWord").focus();
          return false;
        } //if(검색어 미입력시)

        SearchFrm.submit();
      }); //#searchBtn(검색어)


      $("#ViewCondition").change(function(){

      });//#ViewCondition

    }); //제이쿼리 최신
  </script>
  <body>
    <div class="board-title-container">
        <div class="board-title-area">
          <h1 class="board-title">문의 게시판(Q&A)</h1>
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
                            <a href="/iView?qbno=${ibdto.qbno}"><div class="default-cut-strings">${ibdto.qtitle}</div></a>
                        </td>
                        <td class="qna-board-list-user">${ibdto.email}</td>
                        <td class="qna-board-list-date"><fmt:formatDate value="${ibdto.qdate}" pattern="yyyy-MM-dd"/></td>
                        <td class="qna-board-list-status">
                            <c:choose>
                                <c:when test="${ibdto.commentCount <= 0}"> <strong style="color: red;">답변대기</strong></c:when>
                                <c:otherwise><strong style="color: blue;">답변완료</strong></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="qna-board-list-view">${ibdto.qhit}</td>
                    </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
            <!--페이징-->
          <div class="pagination-area">
            <ul id="pagination">
              <!--첫번째 페이지-->
              <li class="pagination-first-page"><a href="/inquiry?page=1&searchCategory=${map.searchCategory}&searchWord=${map.searchWord}">처음</a></li>

              <!--이전 페이지-->
              <c:if test="${map.page>=1 }">
                <a href="/inquiry?page=${map.page-1 }&searchCategory=${map.searchCategory}&searchWord=${map.searchWord}"><i class="fa fa-chevron-left" aria-hidden="true"></i></a></li>
              </c:if>

              <!--페이지 넘버링-->
              <c:forEach var="i" begin="${map.startPageNum}" end="${map.endPageNum }" step="1">
                <c:if test="${map.page==i }">
                    <li class="pagination-number">${i}</li>
                </c:if>
                <c:if test="${map.page!=i }">
                    <li class="pagination-number"><a href="/inquiry?page=${i}&searchCategory=${map.searchCategory}&searchWord=${map.searchWord}">${i}</a></li>
                </c:if>
              </c:forEach>
              <!--페이지 넘버링-->

              <!--다음 페이지-->
              <c:if test="${map.page<map.maxPage }">
                <a href="/inquiry?page=${map.page+1 }&searchCategory=${map.searchCategory}&searchWord=${map.searchWord}"><i class="fa fa-chevron-right" aria-hidden="true"></i></a></li>
              </c:if>
              <c:if test="${map.page>=map.maxPage }">
                <i class="fa fa-chevron-right" aria-hidden="true"></i>
              </c:if>
              <!-- 마지막 페이지 -->
              <li class="pagination-last-page">
                <a href="/inquiry?page=${map.maxPage }&searchCategory=${map.searchCategory}&searchWord=${map.searchWord}">마지막</a>
              </li>
            </ul>
          </div>
          <div class="search-area">
          <form action="/inquiry" method="get" name="SearchFrm">
                <select class="search-word-select" name="searchCategory">
                  <c:if test="${map.searchCategory != 'All'}">
                    <option value="All">전체</option>
                  </c:if>
                  <c:if test="${map.searchCategory == 'All'}">
                    <option value="All" selected="selected">전체</option>
                  </c:if>
                  <c:if test="${map.searchCategory == 'Qtitle'}">
                    <option value="Qtitle" selected="selected">제목</option>
                  </c:if>
                  <c:if test="${map.searchCategory != 'Qtitle'}">
                    <option value="Qtitle">제목</option>
                  </c:if>
                  <c:if test="${map.searchCategory == 'Qcontent'}">
                    <option value="Qcontent" selected="selected">내용</option>
                  </c:if>
                  <c:if test="${map.searchCategory != 'Qcontent'}">
                    <option value="Qcontent">내용</option>
                  </c:if>
                  <c:if test="${map.searchCategory == 'Email'}">
                    <option value="Email" selected="selected">작성자</option>
                  </c:if>
                  <c:if test="${map.searchCategory !='Email'}">
                    <option value="Email">작성자</option>
                  </c:if>
                </select>
                <input type="text" class="search-word-input" id="SearchWord" name="searchWord" placeholder=" ※검색어를 입력하세요."/>
                <input type="hidden" id="SearchWord_hidden" value="${map.searchWord}"> <!-- 검색어 검색창 유지기능  -->
                <button id="searchBtn" class="search-word-button">검색</button>
            </form>
          </div>
          <div class="control-area">
            <a class="button" href="/iWrite">글쓰기</a>
          </div>
        </div>
      </div>
  </body>

  <!--◁◀◁◀ Footer ▶▷▶▷ -->
  <%-- <%@ include file="/WEB-INF/views/include/footer.jsp"%> --%>
  <!--◁◀◁◀ Footer ▶▷▶▷ -->
</html>
