package com.newdeal.ledger.calendar.service.impl;

// import com.newdeal.ledger.acct.mapper.CalendarMapper;

import com.newdeal.ledger.calendar.dto.TransactionDto;
import com.newdeal.ledger.calendar.mapper.CalendarMapper;
import com.newdeal.ledger.calendar.service.CalendarService;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
// @RequiredArgsConstructor
public class CalendarServiceImpl implements CalendarService {

    private final CalendarMapper calendarMapper;

    public  CalendarServiceImpl (CalendarMapper calendarMapper){
        this.calendarMapper=calendarMapper;
    }

    @Override
    public List<TransactionDto> findAll(HashMap<Object, String> map) {
        return calendarMapper.findAll(map);
    }

    @Override
    public List<TransactionDto> findDetails(String dateString) {
        return calendarMapper.findDetails(dateString);
    }

    @Override
    public int deleteTransaction(Long tno) {
        return calendarMapper.deleteTransaction(tno);
    }

    @Override
    public TransactionDto getTransactionDetails(int tno) {
        return null; // calendarMapper.findTransactionByTno(tno);
    }
}
