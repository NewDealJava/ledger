package com.newdeal.ledger.account.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.account.dto.AccountDto;
import com.newdeal.ledger.account.dto.AccountRequest;
import com.newdeal.ledger.account.mapper.AccountMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements AccountService {
	private final AccountMapper mapper;

	@Override
	public void createAccount(String email, AccountRequest.Create request) {
		mapper.createAccount(email, request);
	}

	@Override
	public void updateAccount(Integer accountId, AccountRequest.Update request) {
		mapper.updateAccount(accountId, request);
	}

	@Override
	public void removeAccount(Integer accountId) {
		mapper.deleteAccount(accountId);
	}

	@Override
	public List<AccountDto> getAccountsByEmail(String email) {
		return mapper.findAccountsByEmail(email);
	}

}
