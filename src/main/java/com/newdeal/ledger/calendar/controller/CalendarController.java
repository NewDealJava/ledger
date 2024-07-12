package com.newdeal.ledger.calendar.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.newdeal.ledger.calendar.dto.TransactionDto;
import com.newdeal.ledger.calendar.service.CalendarService;
import com.newdeal.ledger.inquiry.service.InquiryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

    private final CalendarService calendarService;
    public CalendarController(CalendarService calendarService){
        this.calendarService=calendarService;
    } //생성자 주입방식

    /**
     * 브라우저에서 특정 년월의 달력 페이지로 이동할 때 사용합니다.
     * JSP 페이지를 반환하여 해당 달력 페이지를 브라우저에 렌더링합니다. (최종 삭제했을때 이쪽 메서드 경유)
     * @param model
     * @return
     */
    @GetMapping // 브라우저에서 특정 년월의 달력 페이지로 이동할 때 사용
    public String calendarPage(@RequestParam(value = "year", required = false) Integer year,
                               @RequestParam(value = "month", required = false) Integer month,
                               Model model) {

        if (year == null || month == null) {
            LocalDate currentDate = LocalDate.now(); // 현재 날짜를 가져옵니다.
            year = currentDate.getYear();
            month = currentDate.getMonthValue();
        }
        
        HashMap<Object, String> map = new HashMap<>();
        map.put("year", String.valueOf(year));
        System.out.println("/calendar = " + map.get("year"));
        map.put("month", String.valueOf(month));
        System.out.println("/calendar = " + map.get("month"));

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

    /**
     * AJAX 요청 등을 통해 비동기적으로 특정 년월의 데이터를 가져올 때 사용합니다.
     * JSON 데이터를 반환하여 클라이언트 측에서 데이터를 처리할 수 있습니다.
     * @param year @param month @param model
     * @return
     */
    @GetMapping(value = "/data", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody // JSON 데이터를 반환하기 위해 사용
    public List<TransactionDto> calendar(@RequestParam(value = "year", required = false) Integer year,
                                         @RequestParam(value = "month", required = false) Integer month,
                                         Model model) {

        System.out.println("/calendar/data = " + year); // 2024
        System.out.println("/calendar/data = " + month); // 6

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
        System.out.println("day@@@@@@@@@@ = " + day);
        // monthYear에서 연도와 월 추출
        int year = Integer.parseInt(monthYear.substring(0, 4)); // 2024
        int month = Integer.parseInt(monthYear.substring(6, 7)); // 7
        // day를 정수로 변환
        int dayOfMonth = Integer.parseInt(day); // 4
        // LocalDate 객체 생성
        LocalDate date = LocalDate.of(year, month, dayOfMonth);
        String dateString = date.toString(); // LocalDate를 String으로 변환
        // System.out.println("dateString = " + dateString); // 2024-07-05
        
        List<TransactionDto> calendars = calendarService.findDetails(dateString);
        // System.out.println("calendar = " + calendar);
        model.addAttribute("calendars", calendars);
        model.addAttribute("backyear", backyear); // 삭제 후에 돌아오기 위해서
        model.addAttribute("backmonth", backmonth); // ...

        return "/calendar/expenseDetails"; // 프래그먼트를 반환
    }

    /**
     * 모델창에서 삭제를 했을 때
     * 리다이렉트로 페이지 이동 vs JSON 데이터 반환 장단점 확인
     * @PostMapping(value = "/deleteTransaction", produces = MediaType.APPLICATION_JSON_VALUE)
     * @ResponseBody // 문제 : 삭제 작업을 처리한 후에 원하는 대로 리다이렉트 또는 달력 데이터를 다시 로드하지 못함 -> 삭제하고 JSON 형식의 문자열을 반환하도록 수정
     * @param tno @param backyear @param backmonth @param redirectAttributes @param model
     * @return
     */
    @PostMapping("/deleteTransaction") // 삭제 로직 구현
    // @ResponseBody // JSON 데이터를 반환하기 위해 사용, ResponseEntity<?>
    public String deleteTransaction(@RequestParam Long tno,
                                    @RequestParam(value = "backyear", required = false) Integer backyear,
                                    @RequestParam(value = "backmonth", required = false) Integer backmonth,
                                    RedirectAttributes redirectAttributes,
                                    Model model) {

        System.out.println("backyear : " + backyear); // 2024
        System.out.println("backmonth : " + backmonth); // 4

        int success = calendarService.deleteTransaction(tno);

        if (success == 1) {
            System.out.println("삭제에 성공하였습니다");
            // 삭제 후 해당 년월의 데이터를 가져옴
            LocalDate currentDate = LocalDate.now();
            if (backyear == null) {
                backyear = currentDate.getYear();
            }
            if (backmonth == null) {
                backmonth = currentDate.getMonthValue();
            }

            HashMap<Object, String> map = new HashMap<>();
            map.put("year", String.valueOf(backyear));
            map.put("month", String.valueOf(backmonth));

            List<TransactionDto> calendars = calendarService.findAll(map);
            // RedirectAttributes에 데이터 추가
            redirectAttributes.addFlashAttribute("calendars", calendars);
            redirectAttributes.addAttribute("year", backyear);
            redirectAttributes.addAttribute("month", backmonth);

            return "redirect:/calendar";
        } else {
            redirectAttributes.addFlashAttribute("error", "삭제에 실패하였습니다.");
            return "redirect:/error-page"; // 실패 시 에러 페이지로 리다이렉트
        }
    }

    /**
     * 키워드와 금액을 수정
     * @param tno @param newKeyword @param newAmount @param model
     * @return
     */
    @PostMapping("/updateTransaction")
    public ResponseEntity<String> updateTransaction(@RequestParam Long tno,
                                                    @RequestParam String newKeyword,
                                                    @RequestParam Integer newAmount,
                                                    Model model) {

        System.out.println("tno = " + tno);
        System.out.println("newKeyword = " + newKeyword);
        System.out.println("newAmount = " + newAmount);

        try {
            // 성공적으로 수정된 경우
            return ResponseEntity.ok("Transaction updated successfully"); // 성공 응답

        } catch (Exception e) {
            e.printStackTrace();
            // 수정 중 에러가 발생한 경우
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating transaction");
        }
    }
}
