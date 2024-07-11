<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>가계부</title>

    <!-- CSS -->
    <link href="../css/include/global.css?ver=1" rel="stylesheet" />
    <link href="../css/user.css?ver=1" rel="stylesheet" />

    <!-- JQuery 최신 -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    
    <!---JQuery Validate--->
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"
      integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>
  </head>
  <script>
    $(document).ready(() => {
      $("#checkBtn").click(() => {
        let email = $("#email").val();
        if (!email) {
          alert("이메일을 입력해주세요.");
          return;
        }
        $.ajax({
          url: "/user/check-email",
          type: "GET",
          data: { email: email },
          success: (response) => {
            if (response) {
              alert("입력하신 이메일은 이미 존재합니다.");
            } else {
              alert("입력하신 이메일은 사용이 가능합니다.");
            }
          },
        });
      });
    });

    jQuery(() => {
      const form = $("#signUpForm");
      form.validate({
        rules: {
          email: {
            required: true,
            email: true,
          },
          password: {
            required: true,
            minlength: 8,
          },
          passwordCheck: {
            required: true,
            minlength: 8,
            equalTo: password,
          },
          name: {
            required: true,
            minlength: 3,
          },
          phone: {
            required: true,
            digits: true,
          },
          address: {
            required: true,
          },
        },
        messages: {
          email: {
            required: "이메일을 입력하세요.",
            email: "올바른 이메일 형식으로 입력하세요.",
          },
          password: {
            required: "비밀번호를 입력하세요.",
            minlength: "최소 {0}글자 이상 입력하세요.",
          },
          passwordCheck: {
            required: "비밀번호를 다시 입력하세요.",
            minlength: "최소 {0}글자 이상 입력하세요.",
            equalTo: "비밀번호가 일치하지 않습니다.",
          },
          name: {
            required: "이름을 입력하세요.",
            minlength: "최소 {0}글자 이상 입력하세요.",
          },
          phone: {
            required: "휴대전화 번호를 입력하세요.",
            digits: "반드시 숫자만 입력하세요.",
          },
          address: {
            required: "주소를 입력하세요.",
          },
        },
        errorPlacement: (error, element) => {
          $(element)
            .closest("form")
            .find("p[for='" + element.attr("id") + "']")
            .append(error);
        },

        onfocusout: (element) => {
          $(element).valid();
        },
      });
    });
  </script>
  <body>
    <form id="signUpForm" action="/user/sign-up" method="post">
      <div id="auth">
        <div class="sign-up-card">
          <div class="auth-card-box sign-up">
            <div class="input-box">
              <div class="input-container">
                <input
                  id="email"
                  name="email"
                  class="input"
                  type="text"
                  placeholder="이메일주소"
                  required
                />
                <button
                  id="checkBtn"
                  type="button"
                  class="input-duplicate-button"
                >
                  중복확인
                </button>
              </div>
              <p for="email" style="color: red"></p>
              <div class="input-container">
                <input
                  id="password"
                  name="password"
                  class="input"
                  type="password"
                  placeholder="비밀번호"
                  required
                />
              </div>
              <p for="password" style="color: red"></p>
              <div class="input-container">
                <input
                  id="passwordCheck"
                  name="passwordCheck"
                  class="input"
                  type="password"
                  placeholder="비밀번호 재입력"
                  required
                />
              </div>
              <p for="passwordCheck" style="color: red"></p>
              <div class="input-container">
                <input
                  id="name"
                  name="name"
                  class="input"
                  type="text"
                  placeholder="이름"
                  required
                />
              </div>
              <p for="name" style="color: red"></p>
              <div class="input-container">
                <input
                  id="phone"
                  name="phone"
                  class="input"
                  type="text"
                  placeholder="휴대전화"
                  required
                />
              </div>
              <p for="phone" style="color: red"></p>
              <div class="input-container">
                <input
                  id="address"
                  name="address"
                  class="input"
                  type="text"
                  placeholder="주소"
                  required
                />
              </div>
              <p for="address" style="color: red"></p>
            </div>
            <button type="submit" class="login-button">회원가입</button>
            <div><a href="sign-in" class="sign-text">로그인</a></div>
          </div>
        </div>
      </div>
    </form>
  </body>
</html>
