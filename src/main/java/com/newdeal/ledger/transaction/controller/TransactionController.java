package com.newdeal.ledger.transaction.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.newdeal.ledger.transaction.dto.TransactionListDto;
import com.newdeal.ledger.transaction.service.TransactionService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/transaction")
@RequiredArgsConstructor
public class TransactionController {
	private final TransactionService transactionService;

	@GetMapping
	public String getTransactions(Model model) {
		String tempEmail = "user1@example.com";
		int tempYear = 2024;
		int tempMonth = 7;

		List<TransactionListDto> transactionListDtos = transactionService.selectAllByMonth(
			tempEmail,
			tempYear,
			tempMonth
		);

		System.out.println("dd");
		model.addAttribute("transactionDtos", transactionListDtos);

		return "/transaction";
	}
}
