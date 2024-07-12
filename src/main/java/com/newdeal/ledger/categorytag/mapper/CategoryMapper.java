package com.newdeal.ledger.categorytag.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.newdeal.ledger.categorytag.dto.CategoryDto;

@Mapper
public interface CategoryMapper {
	List<CategoryDto> findAll();
}
