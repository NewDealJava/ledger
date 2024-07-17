package com.newdeal.ledger.account.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.account.dto.AccountDto;
import com.newdeal.ledger.account.dto.AccountRequest;
import com.newdeal.ledger.account.service.AccountService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value = "/api/account")
@RequiredArgsConstructor
public class AccountRestController {
	private final AccountService accountService;

	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	public void createAccount (@ModelAttribute AccountRequest.Create request) {
		String tempEmail = "user1@example.com";
		accountService.createAccount(tempEmail, request);
	}

	@PutMapping(value = "/{accountId}")
	@ResponseStatus(HttpStatus.OK)
	public void updateAccount (@PathVariable Integer accountId, @RequestBody AccountRequest.Update request) {
		accountService.updateAccount(accountId, request);
	}

	@DeleteMapping(value = "/{accountId}")
	@ResponseStatus(HttpStatus.OK)
	public void removeAccount(@PathVariable Integer accountId) {
		accountService.removeAccount(accountId);
	}

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	public List<AccountDto> getAccountsByEmail() {
		String tempEmail = "user1@example.com";

		return accountService.getAccountsByEmail(tempEmail);
	}
}
