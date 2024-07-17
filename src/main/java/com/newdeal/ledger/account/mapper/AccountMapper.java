package com.newdeal.ledger.account.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.account.dto.AccountDto;
import com.newdeal.ledger.account.dto.AccountRequest;
import com.newdeal.ledger.account.dto.AccountResponse;

@Mapper
public interface AccountMapper {
	void createAccount(@Param("email") String email, @Param("request") AccountRequest.Create request);

	void updateAccount(@Param("accountId") Integer accountId, @Param("request") AccountRequest.Update request);

	void deleteAccount(Integer accountId);
	List<AccountResponse.GetOne> findAccountsByEmail(String email);
}
