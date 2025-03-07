package com.newdeal.ledger.category.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.category.dto.CategoryResponse;
import com.newdeal.ledger.transaction.dto.type.TransactionType;

@Mapper
public interface CategoryMapper {
	List<CategoryResponse.GetOne> findCategories();

	List<CategoryResponse.GetOne> findCategoriesByType(@Param("type") TransactionType type);

	List<CategoryResponse.GetOne> findSubcategoriesByCategoryId(Integer parentCategoryId);
}
