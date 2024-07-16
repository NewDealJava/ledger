package com.newdeal.ledger.cardaccount.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.cardaccount.dto.AccountDto;
import com.newdeal.ledger.cardaccount.dto.AccountRequest;
import com.newdeal.ledger.cardaccount.mapper.AccountMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements AccountService {
	private final AccountMapper mapper;

	@Override
	public List<AccountDto> selectAllByEmail(String email) {
		return mapper.findAllByEmail(email);
	}

	@Override
	public void createAccount(String email, AccountRequest.Create request){
		mapper.createAccount(email, request);
	}

	@Override
	public void updateAccount(Integer accountId, AccountRequest.Update request) {
		mapper.updateAccount(accountId, request);
	}

	@Override
	public void deleteAccount(Integer accountId) {
		mapper.deleteAccount(accountId);
	}
}
