package com.newdeal.ledger.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class UserViewController {

  // 회원가입 화면 뷰 페이지
  @GetMapping("sign-up")
  public String signUp() {
    return "/user/sign-up";
  }

  // 로그인 화면 뷰 페이지
  @GetMapping("sign-in")
  public String signIn() {
    return "/user/sign-in";
  }

  // 마이페이지 화면 뷰 페이지
  @GetMapping("user/mypage")
  public String mypage() {
    return "/user/mypage";
  }
}
