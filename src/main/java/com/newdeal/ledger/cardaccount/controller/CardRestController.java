package com.newdeal.ledger.cardaccount.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.cardaccount.dto.CardDto;
import com.newdeal.ledger.cardaccount.service.CardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value = "/api/card")
@RequiredArgsConstructor
public class CardRestController {
	private final CardService cardService;

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	public List<CardDto> getAllCardsByEmail() {
		String tempEmail = "user1@example.com";

		return cardService.selectAllByEmail(tempEmail);
	}
}
