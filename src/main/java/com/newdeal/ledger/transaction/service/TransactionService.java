package com.newdeal.ledger.transaction.service;

import java.util.List;

import com.newdeal.ledger.transaction.dto.TransactionListDto;

public interface TransactionService {

	List<TransactionListDto> selectAllByMonth(String email, int year, int month);
}
