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
  <body>
    <div class="board-title-container">
      <div class="board-title-area">
        <h1 class="board-title">문의하기(Q/A) 수정</h1>
      </div>

      <div class="board-write-container">
        <form action="post">
          <div class="board-write-title-area">
            <label for="board-write-title-input" class="board-write-title">제목</label>
            <div class="board-write-title-input-wrap">
              <input id="board-write-title-input" class="board-write-title-input" type="text" value="${ibdto.qtitle}" />
            </div>
          </div>

          <div class="board-write-content-area">
            <div class="board-write-content"></div>
          </div>
          <div class="board-write-button-area">
            <a class="button" href="/inquiry">돌아가기</a>
            <a class="button" href="#">수정하기</a>
          </div>
        </form>
      </div>
  </body>

  <!--◁◀◁◀ Footer ▶▷▶▷ -->
  <%-- <%@ include file="/WEB-INF/views/include/footer.jsp"%> --%>
  <!--◁◀◁◀ Footer ▶▷▶▷ -->
</html>
<script>
  const editor = new toastui.Editor({
          el: document.querySelector('.board-write-content'), // 에디터를 적용할 요소 (컨테이너)
          height: '100%',                        // 에디터 영역의 높이 값 (OOOpx || auto)
          initialEditType: 'markdown',            // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
          initialValue: qContent,     // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
          previewStyle: 'tab'                // 마크다운 프리뷰 스타일 (tab || vertical)
      });
</script>
