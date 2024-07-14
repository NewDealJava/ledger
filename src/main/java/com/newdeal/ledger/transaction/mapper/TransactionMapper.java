package com.newdeal.ledger.transaction.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionListDto;
import com.newdeal.ledger.transaction.dto.TransactionRequest;
import com.newdeal.ledger.transaction.dto.TransactionTagDto;

@Mapper
public interface TransactionMapper {
	List<TransactionListDto> findAllByMonth(
		@Param("email") String email,
		@Param("year") int year,
		@Param("month") int month
	);

	List<SourceDto> findAllSourceByEmail(String email);

	// Integer createTransaction(String email, TransactionRequest.Create request);
	Integer createTransaction(@Param("email") String email, @Param("request") TransactionRequest.Create request);

	void createTransactionTagMapper(List<TransactionTagDto> transactionTagDtos);

}
