package com.newdeal.ledger.cardaccount.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.cardaccount.dto.AccountDto;
import com.newdeal.ledger.cardaccount.dto.AccountRequest;

@Mapper
public interface AccountMapper {
	List<AccountDto> findAllByEmail(String email);

	void createAccount(@Param("email") String email, @Param("request") AccountRequest.Create request);
}
