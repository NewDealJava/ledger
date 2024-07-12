package com.newdeal.ledger.cardaccount.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/cardaccount")
public class CardAccountController {

	@GetMapping
	public String getCardAccount() {
		return "/cardaccount";
	}

}
