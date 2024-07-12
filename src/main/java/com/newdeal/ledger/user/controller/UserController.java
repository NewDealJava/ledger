package com.newdeal.ledger.user.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.newdeal.ledger.user.dto.UserDto;
import com.newdeal.ledger.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/user/")
@RequiredArgsConstructor
public class UserController {
	private final UserService userService;

	// 회원가입 화면 뷰 페이지
	@GetMapping("sign-up")
	public String signUp() {
		return "/user/sign-up";
	}

	// 회원가입시 중복확인 버튼 처리 로직
	@GetMapping("check-email")
	public ResponseEntity<Boolean> findByEmail(@RequestParam String email) {
		boolean findByEmail = userService.findByEmail(email);
		return ResponseEntity.status(HttpStatus.OK).body(findByEmail);
	}

	// 로그인 화면 뷰 페이지
	@GetMapping("sign-in")
	public String signIn() {
		return "/user/sign-in";
	}

	// 마이페이지 화면 뷰 페이지
	@GetMapping("mypage")
	public String mypage() {
		return "/user/mypage";
	}

	// 회원가입 처리 로직
	@PostMapping("sign-up")
	public String signUp(UserDto user, Model model) {
		userService.signUp(user);
		return "redirect:/user/sign-in";
	}

	// 로그인 처리 로직
	@PostMapping("sign-in")
	public String signIn(@RequestParam("email") String email, @RequestParam("password") String password, Model model,
			HttpServletRequest request) {
		UserDto dto = userService.selectByEmail(email);

		if (dto != null && userService.matchesPassword(password, dto.getPassword())) {
			HttpSession session = request.getSession();
			session.setAttribute("user", dto);
			return "redirect:/user/mypage";
		} else {
			model.addAttribute("error", "이메일과 비밀번호를 정확하게 입력해주세요.");
			return "/user/sign-in";
		}
	}

	// @GetMapping("/edit/{id}")
	// public String editSampleForm(@PathVariable Long id, Model model) {
	// SampleDto sample = userService.findById(id);
	// model.addAttribute("sample", sample);
	// return "sample/edit";
	// }

	// @PostMapping("/edit")
	// public String editSample(@ModelAttribute SampleDto sample) {
	// sampleService.save(sample);
	// return "redirect:/sample";
	// }

	// @GetMapping("/delete/{id}")
	// public String deleteSample(@PathVariable Long id) {
	// sampleService.deleteById(id);
	// return "redirect:/sample";
	// }

}
