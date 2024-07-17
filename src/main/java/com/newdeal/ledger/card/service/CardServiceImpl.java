package com.newdeal.ledger.card.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.card.dto.CardDto;
import com.newdeal.ledger.card.dto.CardRequest;
import com.newdeal.ledger.card.mapper.CardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CardServiceImpl implements CardService {
	private final CardMapper mapper;

	@Override
	public void createCard(String email, CardRequest.Create request) {
		mapper.createCard(email, request);
	}

	@Override
	public void updateCard(Integer cardId, CardRequest.Update request) {
		mapper.updateCard(cardId, request);
	}

	@Override
	public void removeCard(Integer cardId) {
		mapper.deleteCard(cardId);
	}

	@Override
	public List<CardDto> getCardsByEmail(String email) {
		return mapper.findCardsByEmail(email);
	}

}
