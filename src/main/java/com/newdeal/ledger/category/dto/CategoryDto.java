package com.newdeal.ledger.category.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CategoryDto {
	public Integer categoryId;
	public CategoryType type;
	public String name;
	public Integer parentCategoryId;
}
