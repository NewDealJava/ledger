<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>가계부</title>
    <!-- CSS -->
    <link href="/css/include/global.css?ver=1" rel="stylesheet" />
    <link href="/css/user.css?ver=1" rel="stylesheet" />
    <!-- JQuery 최신 -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <!-- Sweet Alert -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
    <script type="text/javascript" src="/js/toast-alert.js"></script>
  </head>

<script>
$(document).ready(() => {
  $("#signIpForm").submit((e) => {
    e.preventDefault();
    let email = $("#email").val();
    let password = $("#password").val();
    if (!email || !password) {
      Toast.fire({
        icon: "error",
        title: "아이디와 비밀번호를 입력하세요.",
      });
      return;
    }
    $.ajax({
      url: "/user/sign-in",
      type: "POST",
      data: JSON.stringify({
        email: email,
        password: password,
      }),
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: (response) => {
          sessionStorage.setItem(
            "successMessage",
            "님 환영합니다!"
          );
          window.location.href = "/user/mypage";
      },
      error: (error) => {
        if (error.status === 400) {
        Toast.fire({
          icon: "error",
          title: "비밀번호가 일치하지 않습니다.",
        });
        }
        if (error.status === 404) {
        Toast.fire({
          icon: "error",
          title: "존재하지 않는 이메일입니다.",
        });
        }
      },
    });
  });
});
</script>

  <body>
    <form id="signIpForm">
      <div id="auth">
        <div class="sign-in-card">
          <div class="auth-card-box sign-in">
            <div class="user-button kakao-button">
              <div class="icon-wrapper">
                <img
                  src="../img/kakao-icon.png"
                  alt="카카오아이콘"
                  width="20px"
                  height="20px"
                />
              </div>
              <div>카카오 계정으로 로그인</div>
              <div></div>
            </div>

            <div class="user-button google-button">
              <div class="icon-wrapper">
                <img
                  src="../img/google-icon.png"
                  alt="구글아이콘"
                  width="20px"
                  height="20px"
                />
              </div>
              <div>구글 계정으로 로그인</div>
              <div></div>
            </div>
            <p>또는</p>
            <div class="input-box">
              <div class="input-container">
                <input
                  id="email"
                  name="email"
                  class="input"
                  type="text"
                  placeholder="이메일주소"
                />
              </div>
              <div class="input-container">
                <input
                  id="password"
                  name="password"
                  class="input"
                  type="password"
                  placeholder="비밀번호"
                />
              </div>
              <c:if test="${not empty error }">
                <p
                  style="
                    color: red;
                    display: flex;
                    justify-content: center;
                    margin-top: 15px;
                  "
                >
                  ${error}
                </p>
              </c:if>
            </div>
            <button id="loginBtn" class="login-button">로그인</button>
            <div><a href="/sign-up" class="sign-text">회원가입</a></div>
          </div>
        </div>
      </div>
    </form>
  </body>
</html>
<script>
  $(document).ready(() => {
    const successMessage = sessionStorage.getItem('successMessage');
    if (successMessage) {
        Toast.fire({
            icon: 'success',
            title: successMessage,
        });
        sessionStorage.removeItem('successMessage');
    }
});
  $(document).ready(() => {
    const logoutMessage = sessionStorage.getItem('logoutMessage');
    if (logoutMessage) {
        Toast.fire({
            icon: 'success',
            title: logoutMessage,
        });
        sessionStorage.removeItem('logoutMessage');
    }
});
</script>