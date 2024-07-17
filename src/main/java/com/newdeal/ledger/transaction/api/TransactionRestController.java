package com.newdeal.ledger.transaction.api;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionRequest;
import com.newdeal.ledger.transaction.dto.TransactionResponse;
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

	@PutMapping(value = "/{transactionId}")
	@ResponseStatus(HttpStatus.OK)
	public void updateTransactionById(@PathVariable Integer transactionId,
		@ModelAttribute TransactionRequest.Update request) {
		transactionService.updateTransactionById(transactionId, request);
	}

	@DeleteMapping(value = "/{transactionId}")
	@ResponseStatus(HttpStatus.OK)
	public void removeTransactionById(@PathVariable Integer transactionId) {
		transactionService.removeTransactionById(transactionId);
	}

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	public List<TransactionResponse.GetList> getTransactions(@RequestParam int year, @RequestParam int month) {
		String tempEmail = "user1@example.com";
		return transactionService.getTransactionsByMonth(tempEmail, year, month);
	}

	@GetMapping("/search")
	@ResponseStatus(HttpStatus.OK)
	public List<TransactionResponse.GetList> getTransactionsByMultiFilter(
		@ModelAttribute TransactionRequest.MultiFilter request
	) {
		String tempEmail = "user1@example.com";
		return transactionService.getTransactionsByMultiFilter(tempEmail, request);
	}

	@GetMapping(value = "/{transactionId}")
	@ResponseStatus(HttpStatus.OK)
	public TransactionResponse.GetOne getTransactionById(@PathVariable Integer transactionId) {
		transactionService.createRepeatTypeTransactions();
		return transactionService.getTransactionById(transactionId);
	}

	@GetMapping("/source")
	@ResponseStatus(HttpStatus.OK)
	public List<SourceDto> getSource() {
		String tempEmail = "user1@example.com";
		List<SourceDto> sourceDtos = transactionService.getSourcesByEmail(tempEmail);
		return sourceDtos;
	}
}
