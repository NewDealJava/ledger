package com.newdeal.ledger.tag.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

public class TagRequest {

	@Data
	public static class Create {
		@NotBlank
		public String name;
	}

	@Data
	public static class Update {
		@NotBlank
		public String name;
	}
}
