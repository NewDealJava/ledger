<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>YOONICORN 가계부</title>
  </head>
  <!-- ♣♣♣ CSS ♣♣♣ -->
  <link href="../css/include/global.css?ver=1" rel="stylesheet" />
  <link href="../css/iWrite.css?ver=1" rel="stylesheet" />

  <!-- JQuery 최신 -->
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>

  <!--◁◀◁◀ Header ▶▷▶▷ -->
  <%@ include file="/WEB-INF/views/include/header.jsp"%>
  <!--◁◀◁◀ Header ▶▷▶▷ -->

  <!-- TUI 에디터 CSS CDN -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
  <script>
  $(function() {
          const qContent = "${fn:escapeXml(ibdto.qcontent)}"; // ibdto.qcontent 값을 JavaScript 변수로 전달
          const editor = new toastui.Editor({
              el: document.querySelector('.board-write-content'), // 에디터를 적용할 요소 (컨테이너)
              height: '400px', // 적절한 높이 설정
              initialEditType: 'markdown', // 초기 에디터 타입 설정 (markdown 또는 wysiwyg)
              initialValue: qContent, // ibdto.qcontent 값을 초기 내용으로 설정
              previewStyle: 'tab', // 프리뷰 스타일 설정
          }); //markDown 설정

          // 저장 버튼 클릭 시 폼 제출
          $("#iWriteSaveBtn").click(function() {
              if ($("#board-write-title-input").val().trim().length < 1) {
                  alert("게시글 제목을 입력해주세요.");
                  $("#board-write-title-input").focus();
                  return false;
              }// 제목 유효성 검사(게시글 제목 미입력시)

              // ▼ ★ TUI Editor에서 markdown 형식의 내용을 가져와 hidden input에 설정
              const markdownContent = editor.getMarkdown();
              $("#qcontent").val(markdownContent);


              if ($("#qcontent").val().trim().length < 1) {
                  alert("게시글 내용을 입력해주세요.");
                  return false;
              }// 내용 유효성 검사(게시글 내용 미입력시)

              // ※ 폼 제출
              document.inquiryWriteFrm.submit();
          }); //#iWriteSaveBtn
      });//제이쿼리 최신
  </script>

  <body>
    <div class="board-title-container">
      <div class="board-title-area">
        <h1 class="board-title">문의하기(Q&A)</h1>
      </div>

      <div class="board-write-container">
        <form action="/iDoWrite" name="inquiryWriteFrm" method="post">
          <div class="board-write-title-area">
            <label for="board-write-title-input" class="board-write-title">제목</label>
            <div class="board-write-title-input-wrap">
              <input id="board-write-title-input" class="board-write-title-input" name="qtitle" type="text" value="${ibdto.qtitle}" placeholder=" ※ 게시글 제목을 입력해주세요." />
            </div>
          </div>

          <div class="board-write-content-area">
           <!-- Hidden input to store content from TUI Editor -->
            <input type="hidden" id="qcontent" name="qcontent" value="${ibdto.qcontent}"  />
            <div class="board-write-content"></div>
          </div>
          <div class="board-write-button-area">
            <a class="button" href="/inquiry">돌아가기</a>
            <button class="button"><span id="iWriteSaveBtn">저장하기</span></button>
          </div>
        </form>
      </div>
  </body>

  <!--◁◀◁◀ Footer ▶▷▶▷ -->
  <%-- <%@ include file="/WEB-INF/views/include/footer.jsp"%> --%>
  <!--◁◀◁◀ Footer ▶▷▶▷ -->
</html>