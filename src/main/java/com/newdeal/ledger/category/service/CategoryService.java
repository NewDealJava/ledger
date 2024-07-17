package com.newdeal.ledger.category.service;

import java.util.List;

import com.newdeal.ledger.category.dto.CategoryDto;
import com.newdeal.ledger.category.dto.CategoryResponse;

public interface CategoryService {

	List<CategoryResponse.GetOne> getCategories();
	List<CategoryResponse.GetOne> getCategoriesByTransactionType(String type);

	List<CategoryResponse.GetOne> getSubcategories(Integer parentCategoryId);
}
