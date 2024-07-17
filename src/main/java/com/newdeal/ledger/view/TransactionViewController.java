package com.newdeal.ledger.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/view/transaction")
@RequiredArgsConstructor
public class TransactionViewController {

	@GetMapping
	public String getTransactions() {
		return "/transaction/transaction";
	}
}
