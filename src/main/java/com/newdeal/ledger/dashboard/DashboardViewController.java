package com.newdeal.ledger.dashboard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/view/dashboard")
public class DashboardViewController {

	@GetMapping
	public String getView() {
		return "/dashboard/dashboard";
	}
}
