package com.newdeal.ledger.card.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.card.dto.CardDto;
import com.newdeal.ledger.card.dto.CardRequest;
import com.newdeal.ledger.card.dto.CardResponse;

@Mapper
public interface CardMapper {
	void createCard(@Param("email") String email, @Param("request") CardRequest.Create request);

	void updateCard(@Param("cardId") Integer cardId, @Param("request") CardRequest.Update request);

	void deleteCard(Integer cardId);

	List<CardResponse.GetOne> findCardsByEmail(String email);

}
