package com.newdeal.ledger.cardaccount.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.cardaccount.dto.CardDto;
import com.newdeal.ledger.cardaccount.mapper.CardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CardServiceImpl implements CardService {
	private final CardMapper mapper;

	public List<CardDto> selectAllByEmail(String email) {
		return mapper.findAllByEmail(email);
	}

}
