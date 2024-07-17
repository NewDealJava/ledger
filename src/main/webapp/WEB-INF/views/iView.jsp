<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    let qbno=${map.ibdto.qbno};
    let q_ccontent=$("#comment-content").val();
    $(() => {
        $("#iUpdateBtn").click(function(){
           alert("※ 문의사항 수정 페이지로 이동합니다.");
           $("#inquiryViewFrm").attr("action", "iUpdate").submit();
        }); //#iUpdateBtn

        $("#iDelBtn").click(function(){
          if(confirm("※ 게시글을 삭제 하시겠습니까?")){
           $("#inquiryViewFrm").attr("action", "iDelete").submit();
          }//if(confirm)) // 게시글 삭제 alert
        }); //#iDelBtn

        $("iCommentSaveBtn").click(function(){
            if ($("#comment-content").val().length < 1) {
              alert("※ 댓글을 입력해주세요.");
              $("#comment-content").focus();
              return false;
              } //댓글 미입력 방지
        });//iCommentSaveBtn : 댓글 저장

    }); //제이쿼리 최신

    const resize = (obj) => {
    obj.style.height = '37px';
    obj.style.height = (12 + obj.scrollHeight) + 'px';
} //resize
  </script>

  <script>
    $(document).ready(() => {
        $('#edit-btn').on('click', () => {
            const commentContent = $('#comment-list-content');
            const editTextarea = $('#comment-edit-content');
            const saveBtn = $('#save-btn');
            const deleteBtn = $('#delete-btn');
            const cancleBtn = $('#cancle-btn');
            const editBtn = $('#edit-btn');

            // 현재 댓글 텍스트를 textarea에 복사
            editTextarea.val(commentContent.text());

            // 댓글 텍스트와 수정 버튼을 숨기고, textarea와 저장 버튼을 표시
            commentContent.hide();
            editBtn.hide();
            deleteBtn.hide();
            editTextarea.show();
            saveBtn.show();
            cancleBtn.show();
        });
        $('#cancle-btn').on('click', () => {
            const commentContent = $('#comment-list-content');
            const editTextarea = $('#comment-edit-content');
            const saveBtn = $('#save-btn');
            const deleteBtn = $('#delete-btn');
            const cancleBtn = $('#cancle-btn');
            const editBtn = $('#edit-btn');

            // textarea와 저장 버튼을 숨기고, 댓글 텍스트와 수정 버튼을 표시
            editTextarea.hide();
            saveBtn.hide();
            cancleBtn.hide();
            editBtn.show();
            commentContent.show();
            deleteBtn.show();
        }); //댓글수정 취소

        $('#save-btn').on('click', () => {
            const commentContent = $('#comment-list-content');
            const editTextarea = $('#comment-edit-content');
            const saveBtn = $('#save-btn');
            const editBtn = $('#edit-btn');
            const newText = editTextarea.val();

            //♠ajax
            $.ajax({
                url: '/edit-comment',  // 서버의 엔드포인트
                type: 'POST',
                data: {"qbno":qbno, "id":"관리자", "q_ccontent":q_ccontent},
                dataType : "json", //data받는 타입
                success: function(data) {
                    alert('댓글이 수정되었습니다.');

                    // textarea의 값을 댓글 텍스트로 복사
                    commentContent.text(comment);

                    // textarea와 저장 버튼을 숨기고, 댓글 텍스트와 수정 버튼을 표시
                    editTextarea.hide();
                    saveBtn.hide();
                    commentContent.show();
                    editBtn.show();
                }, //success
                error: function(error) {
                    alert('댓글 수정에 실패했습니다.');
                } //error
            });//Ajax(댓글저장)
        });//댓글저장하기
    });//제이쿼리
  </script>
  <body>
  <form action="#" id="inquiryViewFrm" method="post">
     <input type="hidden" name="qbno" value="${map.ibdto.qbno }"> <!-- 문의게시글 수정 및 삭제 게시판 번호 넘기기 Form-->
  </form>
   <div class="board-title-container">
       <div class="board-title-area">
         <h1 class="board-title">문의사항(Q&A) 게시글</h1>
       </div>
     <div class="board-container">
       <div class="board-detail-title-area">
         <h1 class="board-detail-title">${map.ibdto.qtitle}</h1>
       </div>
       <div class="board-detail-info-area">
         <div class="board-detail-attr board-detail-info-writer">
           <div class="board-detail-info-name">작성자</div>
           <div class="board-detail-info-value">java_com12</div>
         </div>
         <div class="board-detail-attr board-detail-info-date">
           <div class="board-detail-info-name">작성일</div>
           <div class="board-detail-info-value">${map.ibdto.qdate}</div>
         </div>
         <div class="board-detail-attr board-detail-info-view">
           <div class="board-detail-info-name">조회</div>
           <div class="board-detail-info-value">${map.ibdto.qhit}</div>
         </div>
         <div class="board-detail-attr board-detail-info-status">
           <div class="board-detail-info-name">답변상태</div>
            <c:if test="${map.iCommentCountNum<=0}"><div class="board-detail-info-value"><strong style="color : red;">답변대기</strong></div></c:if>
            <c:if test="${map.iCommentCountNum>0}"><div class="board-detail-info-value"><strong style="color : blue;">답변완료</strong></div></c:if>
         </div>
       </div>
       <div class="board-detail-content-area">
         <div class="board-detail-content">${map.ibdto.qcontent}</div>
       <div class="board-detail-comment-area">
         <div class="board-detail-comment-default">
           <div class="board-detail-comment-wrap">
             <div class="board-detail-comment-header">
               <div class="comment-count">답변
                 <span class="comment-total-count">${map.iCommentCountNum}개</span>
               </div>
               <hr>
             </div>

             <!-- 댓글 리스트 시작 -->
             <div class="board-detail-comment-list">
                 <c:forEach var="iCommentList" items="${map.iCommentlist }">
                      <ul>
                      <li class="board-comments-item">
                        <div class="comment-list-writer"><img src="https://secure.gravatar.com/avatar/9cf19c0c46550fd0007486e412c2edd5?s=24&d=mm&r=g" alt="" width="24" height="24">
                          관리자
                        </div>
                        <div class="comment-list-date">${iCommentList.qcdate}</div>
                        <div id="comment-list-content" class="comment-list-content">${iCommentList.q_ccontent}</div>
                        <textarea name="comment-edit-content" id="comment-edit-content" class="comment-edit-content" style="display: none;" onkeydown="resize(this)" onkeyup="resize(this)" required></textarea>
                        <div class="comment-list-controller">
                          <div class="left">
                            <button id="delete-btn" class="comment-button button-delete" type="button">삭제</button>
                            <button id="edit-btn" class="comment-button button-update" type="button">수정</button>
                            <button id="cancle-btn" class="comment-button button-cancle" style="display: none;" type="button">취소</button>
                          </div>
                          <div class="right">
                            <button id="save-btn" class="comment-button button-save" style="display: none;" type="button">저장</button>
                        </div>
                        <hr>
                      </li>
                    </ul>
                </c:forEach>
             </div>
             <!-- 댓글리스트 끝 -->

             <!-- 댓글 작성 폼 시작 -->
             <form action="post">
               <div class="board-detail-comment-form">
                 <div class="comment-field">
                   <textarea name="comment-content" id="comment-content" class="comment-content" placeholder="답변하기..." onkeydown="resize(this)" onkeyup="resize(this)" required></textarea>
                 </div>
                 <div class="comment-submit-button">
                   <input id="iCommentSaveBtn" class="button" type="submit" value="입력"/>
                 </div>
               </div>
             </form>
             <!-- 댓글 작성 폼 끝 -->
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