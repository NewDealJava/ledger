package com.newdeal.ledger.calendar.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.newdeal.ledger.calendar.dto.TransactionDto;
import com.newdeal.ledger.calendar.service.CalendarService;
import com.newdeal.ledger.inquiry.service.InquiryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/calendar")
// @RequiredArgsConstructor
public class CalendarController {

    private final CalendarService calendarService;
    public CalendarController(CalendarService calendarService){
        this.calendarService=calendarService;
    } //생성자 주입방식

    @GetMapping // JSP를 반환하기 위해 사용
    public String calendarPage(Model model) {

        System.out.println("값이 없을 때");
        LocalDate currentDate = LocalDate.now(); // 현재 날짜를 가져옵니다.
        int year = currentDate.getYear();
        int month = currentDate.getMonthValue();
        
        HashMap<Object, String> map = new HashMap<>();
        map.put("year", String.valueOf(year));
        map.put("month", String.valueOf(month));
        // System.out.println("map = " + map); // {month=7, year=2024}
        List<TransactionDto> calendars = calendarService.findAll(map); // 현재 월달에 대한 거래 내역을 가져옴
        // System.out.println("calendars = " + calendars); // time=2024-07-10 11:58:47.0
        model.addAttribute("calendars", calendars);

        // calendars를 JSON 형태로 변환하여 문자열로 저장
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            String calendarsJson = objectMapper.writeValueAsString(calendars);
            model.addAttribute("calendarsJson", calendarsJson); // JSON 문자열을 모델에 추가
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return "/calendar/calendar"; // calendar.jsp 페이지를 반환
    }

    @GetMapping(value = "/data", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody // JSON 데이터를 반환하기 위해 사용
    public List<TransactionDto> calendar(@RequestParam(value = "year", required = false) Integer year,
                                         @RequestParam(value = "month", required = false) Integer month,
                                         Model model) {

//        System.out.println("year@@@@@@@@@@@@@@ = " + year); // 2024
//        System.out.println("month@@@@@@@@@@@@@@@@@@ = " + month); // 6

        LocalDate currentDate = LocalDate.now(); // 현재 날짜를 가져옵니다.
        if (year == null) {
            year = currentDate.getYear(); // 현재 년도를 가져옵니다.
        }
        if (month == null) {
            month = currentDate.getMonthValue(); // 현재 월을 가져옵니다.
        }

        HashMap<Object, String> map = new HashMap<>();
//        System.out.println("year : " + year); // 2024
//        System.out.println("month : " + month); // 6
        map.put("year", String.valueOf(year));
        map.put("month", String.valueOf(month));
        // System.out.println("map = " + map); // {month=6, year=2024}
        List<TransactionDto> calendars = calendarService.findAll(map); // 월단위 거래 내역
        model.addAttribute("calendars", calendars); // date=2024-07-01
        // System.out.println("월단위 거래 내역 : " + calendars);
        return calendars;
    }

    @GetMapping("/details")
    public String viewDetails(@RequestParam String day,
                              @RequestParam String monthYear,
                              @RequestParam String backyear,
                              @RequestParam String backmonth,
                              Model model) {

        // monthYear에서 연도와 월 추출
        int year = Integer.parseInt(monthYear.substring(0, 4)); // 2024
        int month = Integer.parseInt(monthYear.substring(6, 7)); // 7
        // day를 정수로 변환
        int dayOfMonth = Integer.parseInt(day); // 4
        // LocalDate 객체 생성
        LocalDate date = LocalDate.of(year, month, dayOfMonth);
        String dateString = date.toString(); // LocalDate를 String으로 변환
        // System.out.println("dateString = " + dateString); // 2024-07-05
        
        List<TransactionDto> calendar = calendarService.findDetails(dateString);
        // System.out.println("calendar = " + calendar);
        model.addAttribute("calendar", calendar);
        model.addAttribute("backyear", backyear); // 삭제 후에 돌아오기 위해서
        model.addAttribute("backmonth", backmonth); // ...

        return "/calendar/expenseDetails"; // 프래그먼트를 반환
    }

//    @PostMapping("/updateTransaction") // 업데이트 로직 구현
//    public String updateTransaction(@ModelAttribute TransactionDto transactionDto) {
//        int success = calendarService.updateTransaction(transactionDto);
//
//        return "redirect:/details"; // 수정 후에 칼렌더 페이지로 리다이렉트
//    }

//    @PostMapping("/deleteTransaction") // 삭제 로직 구현
//    public String deleteTransaction(@RequestParam Long transactionId,
//                                    @RequestParam(value = "backyear", required = false) Integer backyear,
//                                    @RequestParam(value = "backmonth", required = false) Integer backmonth,
//                                    RedirectAttributes redirectAttributes) {
//
//        System.out.println("backyear : " + backyear); // 2023
//        System.out.println("backmonth : " + backmonth); // 2
//
//        int success = calendarService.deleteTransaction(transactionId);
//        if(success == 1){
//            System.out.println("삭제에 성공하였습니다");
//        }else{
//            System.out.println("삭제에 실패하였습니다");
//        }
//
//        // 삭제 후에 다시 해당 년월의 달력 데이터를 요청하기 위해 year와 month 값을 리다이렉트할 URL에 추가
//        if (backyear != null && backmonth != null) {
//            redirectAttributes.addAttribute("year", backyear);
//            redirectAttributes.addAttribute("month", backmonth);
//        }
//
//        return "redirect:/calendar"; // 삭제 후에 칼렌더 페이지로 리다이렉트
//    }
}
