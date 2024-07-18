package com.newdeal.ledger.category.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.category.dto.CategoryDto;
import com.newdeal.ledger.category.dto.CategoryResponse;
import com.newdeal.ledger.category.mapper.CategoryMapper;
import com.newdeal.ledger.transaction.dto.type.TransactionType;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {
	private final CategoryMapper mapper;

	@Override
	public List<CategoryResponse.GetOne> getCategories() {
		return mapper.findCategories();
	}

	@Override
	public List<CategoryResponse.GetOne> getCategoriesByTransactionType(TransactionType type) {
		return mapper.findCategoriesByType(type);
	}

	@Override
	public List<CategoryResponse.GetOne> getSubcategories(Integer parentCategoryId) {
		return mapper.findSubcategoriesByCategoryId(parentCategoryId);
	}

}
