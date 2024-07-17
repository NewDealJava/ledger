package com.newdeal.ledger.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/view/cardaccount")
public class CardAccountViewController {

	@GetMapping
	public String getCardAccount() {
		return "/cardaccount/cardaccount";
	}

}
