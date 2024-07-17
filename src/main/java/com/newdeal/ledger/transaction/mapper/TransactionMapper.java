package com.newdeal.ledger.transaction.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.transaction.dto.SourceDto;
import com.newdeal.ledger.transaction.dto.TransactionDto;
import com.newdeal.ledger.transaction.dto.TransactionRequest;
import com.newdeal.ledger.transaction.dto.TransactionResponse;

@Mapper
public interface TransactionMapper {

	Integer createTransaction(@Param("email") String email, @Param("request") TransactionRequest.Create request);

	void updateTransactionById(
		@Param("transactionId") Integer transactionId,
		@Param("request") TransactionRequest.Update request
	);

	void deleteTransactionById(Integer transactionId);

	List<TransactionResponse.GetList> findTransactionsByMonth(
		@Param("email") String email,
		@Param("year") int year,
		@Param("month") int month
	);

	TransactionResponse.GetOne findTransactionById(Integer transactionId);

	TransactionDto findTransactionDtoById(Integer transactionId);

	List<SourceDto> findSourcesByEmail(String email);

	void createTransactionTag(
		@Param("transactionId") Integer transactionId,
		@Param("tagIdList") List<Integer> tagIdList
	);

	void deleteTransactionTagByTransactionId(Integer transactionId);

}
