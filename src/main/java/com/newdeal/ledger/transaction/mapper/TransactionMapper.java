package com.newdeal.ledger.transaction.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.transaction.dto.TransactionDto;
import com.newdeal.ledger.transaction.dto.TransactionListDto;

@Mapper
public interface TransactionMapper {
	List<TransactionListDto> findAllByMonth(
		@Param("email") String email,
		@Param("year") int year,
		@Param("month") int month
	);
}
