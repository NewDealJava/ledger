<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>가게부</title>
  </head>
  <!-- ♣♣♣ CSS ♣♣♣ -->
  <link href="../css/include/global.css?ver=1" rel="stylesheet" />
  <link href="../css/iView.css?ver=1" rel="stylesheet" />


  <!-- JQuery 최신 -->
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>

  <!--◁◀◁◀ Header ▶▷▶▷ -->
  <%@ include file="/WEB-INF/views/include/header.jsp"%>
  <!--◁◀◁◀ Header ▶▷▶▷ -->

  <script>
    $(function(){
        $("#iUpdateBtn").click(function(){
           alert("※ 문의사항 수정 페이지로 이동합니다.");
           $("#inquiryViewFrm").attr("action", "iUpdate").submit();
        }); //#iUpdateBtn

        $("#iDelBtn").click(function(){
          if(confirm("※ 게시글을 삭제 하시겠습니까?")){
           $("#inquiryViewFrm").attr("action", "iDelete").submit();
          }//if(confirm)) // 게시글 삭제 alert

        }); //#iUpdateBtn
    }); //제이쿼리 최신
  </script>
  <body>
   <form action="#" id="inquiryViewFrm" method="post">
      <input type="hidden" name="qbno" value="${ibdto.qbno }"> <!-- 문의게시글 수정 및 삭제 게시판 번호 넘기기 Form-->
   </form>
    <div class="board-title-container">
        <div class="board-title-area">
          <h1 class="board-title">문의사항(Q&A) 게시글</h1>
        </div>
      <div class="board-container">
        <div class="board-detail-title-area">
          <h1 class="board-detail-title">${ibdto.qtitle}</h1>
        </div>
        <div class="board-detail-info-area">
          <div class="board-detail-attr board-detail-info-writer">
            <div class="board-detail-info-name">작성자</div>
            <div class="board-detail-info-value">java_com12</div>
          </div>
          <div class="board-detail-attr board-detail-info-date">
            <div class="board-detail-info-name">작성일</div>
            <div class="board-detail-info-value">${ibdto.qdate}</div>
          </div>
          <div class="board-detail-attr board-detail-info-view">
            <div class="board-detail-info-name">조회</div>
            <div class="board-detail-info-value">${ibdto.qhit}</div>
          </div>
          <div class="board-detail-attr board-detail-info-status">
            <div class="board-detail-info-name">답변상태</div>
             <c:if test="${ibdto.qstatus<=0}"><div class="board-detail-info-value"><strong style="color : red;">답변대기</strong></div></c:if>
             <c:if test="${ibdto.qstatus>0}"><div class="board-detail-info-value"><strong style="color : blue;">답변완료</strong></div></c:if>
          </div>
        </div>
        <div class="board-detail-content-area">
          <div class="board-detail-content">${ibdto.qcontent}</div>
        <div class="board-detail-comment-area">
          <div class="board-detail-comment-default">
            <div class="board-detail-comment-wrap">
              <div class="board-detail-comment-header">
                <div class="comment-count">
                  전체
                  <span class="comment-total-count">0</span>
                </div>
                <hr>
              </div>

              <div class="board-detail-comment-list">
                <ul></ul>
              </div>

              <form action="post">
                <div class="board-detail-comment-form">
                  <div class="comment-field">
                    <textarea name="comment-content" id="comment-content" placeholder="답변하기..." onkeydown="resize(this)" onkeyup="resize(this)" required></textarea>
                  </div>
                  <div class="comment-submit-button">
                    <input class="button" type="submit" value="입력"/>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
        
        <div class="board-detail-control">
          <div class="left">
            <a class="button" href="/inquiry">목록보기</a>
          </div>
          <div class="right">
            <button class="button" id="iUpdateBtn">수정</button>
            <button class="button" id="iDelBtn">삭제</button>
          </div>
        </div>
      </div>
    </div>
  </body>

<%-- <%@ include file="/WEB-INF/views/board-list.jsp"%> --%>

  <!--◁◀◁◀ Footer ▶▷▶▷ -->
  <%-- <%@ include file="/WEB-INF/views/include/footer.jsp"%> --%>
  <!--◁◀◁◀ Footer ▶▷▶▷ -->
</html>