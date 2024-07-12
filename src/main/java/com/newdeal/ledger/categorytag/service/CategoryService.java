package com.newdeal.ledger.categorytag.service;

import java.util.List;

import com.newdeal.ledger.categorytag.dto.CategoryDto;

public interface CategoryService {
	List<CategoryDto> selectAll();
}
