package com.newdeal.ledger.cardaccount.service;

import java.util.List;

import com.newdeal.ledger.cardaccount.dto.CardDto;
import com.newdeal.ledger.cardaccount.dto.CardRequest;

public interface CardService {
	List<CardDto> selectAllByEmail(String email);

	void createCard(String tempEmail, CardRequest.Create request);
}
