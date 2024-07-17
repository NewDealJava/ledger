package com.newdeal.ledger.transaction.service;

import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionDto;
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
	public List<TransactionResponse.GetList> getTransactionsByMultiFilter(
		String email,
		TransactionRequest.MultiFilter request
	) {
		return  mapper.findTransactionsByMultiFilter(email, request);
	}

	@Override
	public TransactionResponse.GetOne getTransactionById(Integer transactionId) {
		return mapper.findTransactionById(transactionId);
	}

	@Override
	public List<SourceDto> getSourcesByEmail(String email) {
		return mapper.findSourcesByEmail(email);
	}

	@Scheduled(cron = "0 10 1 * * ?")
	public void createRepeatTypeTransactions() {
		System.out.println("ddddd start");
		List<TransactionDto> repeatTypeTransactionDtoList = mapper.findRepeatTypeTransactionDto();

		for (TransactionDto repeatTypeTransactionDto : repeatTypeTransactionDtoList) {
			Integer repeatTypeTransactionId = repeatTypeTransactionDto.getTransactionId();

			List<Integer> tagList = mapper.findTransactionTagByTransactionId(repeatTypeTransactionId)
				.stream()
				.map(transactionTagDto -> transactionTagDto.getTagId())
				.toList();

			mapper.createTransactionByDto(repeatTypeTransactionDto);
			Integer newTransactionId = repeatTypeTransactionDto.getTransactionId();

			mapper.createTransactionTag(newTransactionId, tagList);
		}
	}

}
