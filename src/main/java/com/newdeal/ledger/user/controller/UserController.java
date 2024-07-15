package com.newdeal.ledger.user.controller;

import java.net.URI;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.newdeal.ledger.user.dto.UserDto;
import com.newdeal.ledger.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UserController {
	private final UserService userService;

	// 회원가입 화면 뷰 페이지
	@GetMapping("sign-up")
	public String signUp() {
		return "/user/sign-up";
	}

	// 회원가입시 중복확인 버튼 처리 로직
	@GetMapping("/user/check-email")
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
	@GetMapping("/user/mypage")
	public String mypage() {
		return "/user/mypage";
	}

	// 회원가입 처리 로직
	@PostMapping("/user/sign-up")
	public ResponseEntity<Void> signUp(@RequestBody UserDto dto) {
		boolean isSignUp = userService.signUp(dto);
		if (isSignUp) {
			HttpHeaders headers = new HttpHeaders();
			headers.setLocation(URI.create("/sign-in"));
			return new ResponseEntity<>(headers, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}

	// 로그인 처리 로직
	@PostMapping("/user/sign-in")
	public ResponseEntity<Void> signIn(@RequestBody UserDto requestDto, HttpServletRequest request) {
		UserDto responseDto = userService.selectByEmail(requestDto.getEmail());
		if (responseDto != null && userService.matchesPassword(requestDto.getPassword(), responseDto.getPassword())) {
			HttpSession session = request.getSession();
			HttpHeaders headers = new HttpHeaders();
			session.setAttribute("user", responseDto);
			headers.setLocation(URI.create("/user/mypage"));
			return new ResponseEntity<>(headers, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
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
