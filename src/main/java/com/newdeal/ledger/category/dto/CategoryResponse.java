package com.newdeal.ledger.category.dto;

import lombok.Data;

public class CategoryResponse {

	@Data
	public static class GetOne {
		public Integer categoryId;
		public CategoryType type;
		public String name;
		public Integer parentCategoryId;
	}
}
