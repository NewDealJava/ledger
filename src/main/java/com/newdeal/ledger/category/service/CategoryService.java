package com.newdeal.ledger.category.service;

import java.util.List;

import com.newdeal.ledger.category.dto.CategoryDto;
import com.newdeal.ledger.category.dto.CategoryResponse;
import com.newdeal.ledger.transaction.dto.type.TransactionType;

public interface CategoryService {

	List<CategoryResponse.GetOne> getCategories();
	List<CategoryResponse.GetOne> getCategoriesByTransactionType(TransactionType type);

	List<CategoryResponse.GetOne> getSubcategories(Integer parentCategoryId);
}
