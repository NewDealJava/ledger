package com.newdeal.ledger.tag.dto;

import lombok.Data;

public class TagResponse {

	@Data
	public static class GetOne {
		public Integer tagId;
		public String email;
		public String name;
	}
}
