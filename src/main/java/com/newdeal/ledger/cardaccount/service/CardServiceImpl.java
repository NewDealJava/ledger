package com.newdeal.ledger.cardaccount.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.cardaccount.dto.CardDto;
import com.newdeal.ledger.cardaccount.dto.CardRequest;
import com.newdeal.ledger.cardaccount.mapper.CardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CardServiceImpl implements CardService {
	private final CardMapper mapper;

	public List<CardDto> selectAllByEmail(String email) {
		return mapper.findAllByEmail(email);
	}

	public void createCard(String email, CardRequest.Create request){
		mapper.createCard(email, request);
	}

	public void updateCard(Integer cardId, CardRequest.Update request){
		mapper.updateCard( cardId, request);
	}

	@Override
	public void deleteCard(Integer cardId) {
		mapper.deleteCard(cardId);
	}
}
