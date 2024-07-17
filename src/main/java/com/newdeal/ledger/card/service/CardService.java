package com.newdeal.ledger.card.service;

import java.util.List;

import com.newdeal.ledger.card.dto.CardDto;
import com.newdeal.ledger.card.dto.CardRequest;
import com.newdeal.ledger.card.dto.CardResponse;

public interface CardService {

	void createCard(String tempEmail, CardRequest.Create request);

	void updateCard(Integer cardId, CardRequest.Update request);

	void removeCard(Integer cardId);

	List<CardResponse.GetOne> getCardsByEmail(String email);
}
