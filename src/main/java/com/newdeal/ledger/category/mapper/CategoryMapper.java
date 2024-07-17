package com.newdeal.ledger.category.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.newdeal.ledger.category.dto.CategoryDto;

@Mapper
public interface CategoryMapper {
	List<CategoryDto> findCategories();

	List<CategoryDto> findCategoriesByType(String type);

	List<CategoryDto> findSubcategoriesByCategoryId(Integer categoryId);
}
