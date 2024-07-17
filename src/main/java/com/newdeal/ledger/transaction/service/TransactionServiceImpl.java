package com.newdeal.ledger.transaction.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionRequest;
import com.newdeal.ledger.transaction.dto.TransactionResponse;
import com.newdeal.ledger.transaction.mapper.TransactionMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TransactionServiceImpl implements TransactionService {
	private final TransactionMapper mapper;

	@Override
	public void createTransaction(String email, TransactionRequest.Create request) {
		mapper.createTransaction(email, request);
		Integer transactionId = request.getTransactionId();

		mapper.createTransactionTag(transactionId, request.getTagIdList());
	}

	@Override
	public void updateTransactionById(Integer transactionId, TransactionRequest.Update request) {
		mapper.updateTransactionById(transactionId, request);
		mapper.deleteTransactionTagByTransactionId(transactionId);
		mapper.createTransactionTag(transactionId, request.getTagIdList());
	}

	@Override
	public void removeTransactionById(Integer transactionId) {
		mapper.deleteTransactionTagByTransactionId(transactionId);
		mapper.deleteTransactionById(transactionId);
	}

	@Override
	public List<TransactionResponse.GetList> getTransactionsByMonth(String email, int year, int month) {
		return mapper.findTransactionsByMonth(email, year, month);
	}

	@Override
	public TransactionResponse.GetOne getTransactionById(Integer transactionId) {
		return mapper.findTransactionById(transactionId);
	}

	@Override
	public List<SourceDto> getSourcesByEmail(String email) {
		return mapper.findSourcesByEmail(email);
	}

}
