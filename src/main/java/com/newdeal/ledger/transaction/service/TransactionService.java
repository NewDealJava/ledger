package com.newdeal.ledger.transaction.service;

import java.util.List;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionListDto;
import com.newdeal.ledger.transaction.dto.TransactionRequest;
import com.newdeal.ledger.transaction.dto.TransactionResponse;

public interface TransactionService {

	List<TransactionListDto> selectAllByMonth(String email, int year, int month);

	List<SourceDto> selectAllSourceByEmail(String email);

	void createTransaction(String email, TransactionRequest.Create request);

	TransactionResponse.GetOne getTransactionById(Integer transactionId);

	void updateTransactionById(Integer transactionId, TransactionRequest.Update request);

	void removeTransactionById(Integer transactionId);
}
