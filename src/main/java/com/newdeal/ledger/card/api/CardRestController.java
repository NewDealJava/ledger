package com.newdeal.ledger.card.api;

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

import com.newdeal.ledger.card.dto.CardDto;
import com.newdeal.ledger.card.dto.CardRequest;
import com.newdeal.ledger.card.service.CardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value = "/api/card")
@RequiredArgsConstructor
public class CardRestController {
	private final CardService cardService;

	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	public void createCard(@ModelAttribute CardRequest.Create request) {
		String tempEmail = "user1@example.com";
		cardService.createCard(tempEmail, request);
	}

	@PutMapping(value = "/{cardId}")
	@ResponseStatus(HttpStatus.OK)
	public void updateCard(@PathVariable Integer cardId, @RequestBody CardRequest.Update request) {
		cardService.updateCard(cardId, request);
	}

	@DeleteMapping(value = "/{cardId}")
	@ResponseStatus(HttpStatus.OK)
	public void removeCard(@PathVariable Integer cardId) {
		cardService.removeCard(cardId);
	}

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	public List<CardDto> getCardsByEmail() {
		String tempEmail = "user1@example.com";
		return cardService.getCardsByEmail(tempEmail);
	}

}
