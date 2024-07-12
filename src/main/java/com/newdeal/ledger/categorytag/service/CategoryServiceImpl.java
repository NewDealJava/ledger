package com.newdeal.ledger.categorytag.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.categorytag.dto.CategoryDto;
import com.newdeal.ledger.categorytag.mapper.CategoryMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {
	private final CategoryMapper mapper;

	public List<CategoryDto> selectAll() {
		return mapper.findAll();
	}

}
