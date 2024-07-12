package com.newdeal.ledger.cardaccount.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.cardaccount.dto.AccountDto;
import com.newdeal.ledger.cardaccount.service.AccountService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value = "/api/account")
@RequiredArgsConstructor
public class AccountRestController {
	private final AccountService accountService;

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	public List<AccountDto> getAllCardsByEmail() {
		String tempEmail = "user1@example.com";

		return accountService.selectAllByEmail(tempEmail);
	}
}
