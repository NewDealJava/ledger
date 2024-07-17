package com.newdeal.ledger.user.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.user.dto.UserDto;
import com.newdeal.ledger.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/user/")
@RequiredArgsConstructor
public class UserRestController {
	private final UserService userService;

	// 회원가입시 중복확인 버튼 처리 로직
	@GetMapping("check-email")
	public ResponseEntity<Boolean> findByEmail(@RequestParam String email) {
		boolean response = userService.findByEmail(email);
		return new ResponseEntity<>(response, HttpStatus.OK);
	}

	// 회원가입 처리 로직
	@PostMapping("sign-up")
	public ResponseEntity<UserDto> signUp(@RequestBody UserDto dto) {
		UserDto response = userService.signUp(dto);
		return new ResponseEntity<>(response, HttpStatus.CREATED);
	}

	// 로그인 처리 로직
	@PostMapping("sign-in")
	public ResponseEntity<UserDto> signIn(@RequestBody UserDto dto, HttpServletRequest request) {
		UserDto response = userService.signIn(dto);
		HttpSession session = request.getSession();
		session.setAttribute("user", response);
		return new ResponseEntity<>(response, HttpStatus.OK);
	}

	@PostMapping("logout")
	public ResponseEntity<Void> logout(HttpSession session) {
		session.invalidate();
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
