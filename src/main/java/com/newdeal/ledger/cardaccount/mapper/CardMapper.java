package com.newdeal.ledger.cardaccount.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.cardaccount.dto.CardDto;
import com.newdeal.ledger.cardaccount.dto.CardRequest;

@Mapper
public interface CardMapper {
	List<CardDto> findAllByEmail(String email);

	void createCard(@Param("email") String email, @Param("request") CardRequest.Create request);

	void updateCard(@Param("cardId") Integer cardId, @Param("request") CardRequest.Update request);

	void deleteCard(Integer cardId);
}
