package com.newdeal.ledger.transaction.service;

import java.util.List;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionRequest;
import com.newdeal.ledger.transaction.dto.TransactionResponse;

public interface TransactionService {

	void createTransaction(String email, TransactionRequest.Create request);

	void updateTransactionById(Integer transactionId, TransactionRequest.Update request);

	void removeTransactionById(Integer transactionId);

	List<TransactionResponse.GetList> getTransactionsByMonth(String email, int year, int month);

	TransactionResponse.GetOne getTransactionById(Integer transactionId);

	List<SourceDto> getSourcesByEmail(String email);

	void createRepeatTypeTransactions();
}
