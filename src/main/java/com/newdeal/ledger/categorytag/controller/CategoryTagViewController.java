package com.newdeal.ledger.categorytag.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/categorytag")
public class CategoryTagViewController {

	@GetMapping
	public String getCategoryTag() {
		return "/categorytag";
	}
}
