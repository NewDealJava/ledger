<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>가계부</title>

    <link
      rel="stylesheet"
      type="text/css"
      href="/css/include/global.css?ver=1"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="/css/include/header.css?ver=1"
    />
        <!-- JQuery 최신 -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  </head>

<script>
  $(document).ready(() => {
    $('#username').on('click', () => {
        const userBox = $('#user-box');
        if (userBox.css('display') === 'none') {
            userBox.show();
        } else {
            userBox.hide();
        }
    });
  })
</script>

  <header class="header">
  <div class="header-wrapper">
    <div class="logo">
      <h1>VISUAL BANK</h1>
      <a href="/#menu=dashboard">
        <img
          src="https://dfrlippt5ud4x.cloudfront.net/web/visual_logo_beta_v3.png"
          width="160"
        />
      </a>
    </div>
    <ul class="nav-bar">
      <c:if test="${ user == null }">
        <li><a href="/sign-in" class="sign-in">로그인</a></li>
      </c:if>
      <c:if test="${ user != null }">
        <li><a id="username" class="user-info">${user.name} 님</a></li>
        <div id="user-box" class="header-user-info-box" style="display: none;">
          <div class="header-user-info-mypage-button">마이페이지</div>
          <div class="divider"></div>
          <div class="header-user-info-logout-button">로그아웃</div>
        </div>
      </c:if>
    </ul>
  </div>
  </header>
</html>
