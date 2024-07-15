package com.newdeal.ledger.categorytag.dto;

import lombok.Data;

public class TagRequest {

	@Data
	public static class Create {
		public String name;
	}

	@Data
	public static class Update {
		public String name;
	}
}
