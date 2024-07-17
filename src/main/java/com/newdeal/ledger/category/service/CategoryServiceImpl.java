package com.newdeal.ledger.category.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.category.dto.CategoryDto;
import com.newdeal.ledger.category.mapper.CategoryMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {
	private final CategoryMapper mapper;

	@Override
	public List<CategoryDto> getCategories() {
		return mapper.findCategories();
	}

	@Override
	public List<CategoryDto> getCategoriesByTransactionType(String type) {
		List<CategoryDto> allCategoriesByType = mapper.findCategoriesByType(type);

		return allCategoriesByType;
	}

	@Override
	public List<CategoryDto> getSubcategories(Integer parentCno) {
		return mapper.findSubcategoriesByCategoryId(parentCno);
	}

}
