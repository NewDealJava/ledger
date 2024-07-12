package com.newdeal.ledger.cardaccount.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.newdeal.ledger.cardaccount.dto.AccountDto;

@Mapper
public interface AccountMapper {
	List<AccountDto> findAllByEmail(String email);
}
