package com.newdeal.ledger.category.service;

import java.util.List;

import com.newdeal.ledger.category.dto.CategoryDto;

public interface CategoryService {

	List<CategoryDto> getCategories();
	List<CategoryDto> getCategoriesByTransactionType(String type);

	List<CategoryDto> getSubcategories(Integer parentCno);
}
