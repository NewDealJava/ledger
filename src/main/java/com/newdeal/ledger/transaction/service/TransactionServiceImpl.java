package com.newdeal.ledger.transaction.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionListDto;
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

}
