package com.newdeal.ledger.categorytag.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.categorytag.dto.CategoryDto;
import com.newdeal.ledger.categorytag.service.CategoryService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value = "/api/category")
@RequiredArgsConstructor
public class CategoryRestController {
	private final CategoryService categoryService;

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	public List<CategoryDto> getCategories(@RequestParam String type) {
		return categoryService.getCategoriesByType(type);
	}

	@GetMapping("/subcategory")
	public List<CategoryDto> getSubcategories(@RequestParam Integer parentCno) {
		return categoryService.getSubcategories(parentCno);
	}
}
