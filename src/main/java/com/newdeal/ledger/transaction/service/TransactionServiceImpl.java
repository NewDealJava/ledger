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
	public List<TransactionResponse.GetList> selectAllByMonth(String email, int year, int month) {
		return mapper.findAllByMonth(email, year, month);
	}

	@Override
	public List<SourceDto> selectAllSourceByEmail(String email) {
		return mapper.findAllSourceByEmail(email);
	}

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
	public TransactionResponse.GetOne getTransactionById(Integer transactionId) {
		return mapper.selectTransactionById(transactionId);
	}

	@Override
	public void removeTransactionById(Integer transactionId) {
		mapper.deleteTransactionTagByTransactionId(transactionId);
		mapper.deleteTransactionById(transactionId);
	}
}
