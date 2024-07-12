package com.newdeal.ledger.cardaccount.service;

import java.util.List;

import com.newdeal.ledger.cardaccount.dto.CardDto;

public interface CardService {
	List<CardDto> selectAllByEmail(String email);
}
