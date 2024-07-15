package com.newdeal.ledger.report;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/view/report")
public class ReportViewController {

	@GetMapping
	public String getView(){
		return "/report/report";
	}
}
