package com.newdeal.ledger.cardaccount.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.newdeal.ledger.cardaccount.dto.CardDto;

@Mapper
public interface CardMapper {
	List<CardDto> findAllByEmail(String email);

}
