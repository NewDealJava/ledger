package com.newdeal.ledger.calendar.mapper;

import com.newdeal.ledger.calendar.dto.TransactionDto;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

@Mapper
public interface CalendarMapper {
    List<TransactionDto> findAll(HashMap<Object, String> map); // {month=7, year=2024}

    List<TransactionDto> findDetails(String dateString); // // 2024-07-05

    int deleteTransaction(Long tno);

    TransactionDto findTransactionByTno(int tno);
}
