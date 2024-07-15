package com.newdeal.ledger.cardaccount.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.cardaccount.dto.AccountDto;
import com.newdeal.ledger.cardaccount.mapper.AccountMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements AccountService {
	private final AccountMapper mapper;

	public List<AccountDto> selectAllByEmail(String email) {
		return mapper.findAllByEmail(email);
	}
}
