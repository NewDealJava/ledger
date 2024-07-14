package com.newdeal.ledger.transaction.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionRequest;
import com.newdeal.ledger.transaction.service.TransactionService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value = "/api/transaction")
@RequiredArgsConstructor
public class TransactionRestController {
	private final TransactionService transactionService;

	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	public void createTransaction(@ModelAttribute TransactionRequest.Create request) {

		String tempEmail = "user1@example.com";
		transactionService.createTransaction(tempEmail, request);

	}

	@GetMapping("/source")
	@ResponseStatus(HttpStatus.OK)
	public List<SourceDto> getSource() {
		String tempEmail = "user1@example.com";
		List<SourceDto> sourceDtos = transactionService.selectAllSourceByEmail(tempEmail);


		return sourceDtos;
	}

}
