package com.newdeal.ledger.calendar.service;

import com.newdeal.ledger.calendar.dto.TransactionDto;

import java.util.HashMap;
import java.util.List;

public interface CalendarService {

    List<TransactionDto> findAll(HashMap<Object, String> map);
    List<TransactionDto> findDetails(String dateString);
    int deleteTransaction(Long tno);

    TransactionDto getTransactionDetails(int tno);
}
