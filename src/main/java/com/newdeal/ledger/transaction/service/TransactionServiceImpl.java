package com.newdeal.ledger.transaction.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.categorytag.dto.TagDto;
import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionListDto;
import com.newdeal.ledger.transaction.dto.TransactionRequest;
import com.newdeal.ledger.transaction.dto.TransactionTagDto;
import com.newdeal.ledger.transaction.mapper.TransactionMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TransactionServiceImpl implements TransactionService {
	private final TransactionMapper mapper;

	@Override
	public List<TransactionListDto> selectAllByMonth(String email, int year, int month) {
		return mapper.findAllByMonth(email, year, month);
	}

	@Override
	public List<SourceDto> selectAllSourceByEmail(String email) {
		return mapper.findAllSourceByEmail(email);
	}

	@Override
	public void createTransaction(String email, TransactionRequest.Create request) {
		mapper.createTransaction(email, request);

		Integer tsno = request.getTno();

		List<TransactionTagDto> list = request.getTags()
			.stream()
			.map(tgno -> new TransactionTagDto(tgno, tsno))
			.toList();
		mapper.createTransactionTagMapper(list);
		System.out.println("dd");
	}

}
