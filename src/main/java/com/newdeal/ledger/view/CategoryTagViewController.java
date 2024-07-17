package com.newdeal.ledger.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/view/categorytag")
public class CategoryTagViewController {

	@GetMapping
	public String getCategoryTag() {
		return "/categorytag/categorytag";
	}
}
