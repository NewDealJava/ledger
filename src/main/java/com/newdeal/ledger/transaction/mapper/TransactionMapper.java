package com.newdeal.ledger.transaction.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionDto;
import com.newdeal.ledger.transaction.dto.TransactionListDto;
import com.newdeal.ledger.transaction.dto.TransactionRequest;
import com.newdeal.ledger.transaction.dto.TransactionResponse;
import com.newdeal.ledger.transaction.dto.TransactionTagDto;

@Mapper
public interface TransactionMapper {
	List<TransactionListDto> findAllByMonth(
		@Param("email") String email,
		@Param("year") int year,
		@Param("month") int month
	);

	List<SourceDto> findAllSourceByEmail(String email);

	Integer createTransaction(@Param("email") String email, @Param("request") TransactionRequest.Create request);

	void createTransactionTag(
		@Param("transactionId") Integer transactionId,
		@Param("tagIdList") List<Integer> tagIdList
	);

	TransactionResponse.GetOne selectTransactionById(Integer transactionId);

	void updateTransactionById(
		@Param("transactionId") Integer transactionId,
		@Param("request") TransactionRequest.Update request
	);

	void deleteTransactionTagByTransactionId(Integer transactionId);

	void deleteTransactionById(Integer transactionId);
}
