package com.newdeal.ledger.category.api;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.category.dto.CategoryDto;
import com.newdeal.ledger.category.dto.CategoryResponse;
import com.newdeal.ledger.category.service.CategoryService;
import com.newdeal.ledger.transaction.dto.type.TransactionType;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value = "/api/category")
@RequiredArgsConstructor
public class CategoryRestController {
	private final CategoryService categoryService;

	@GetMapping("/all")
	@ResponseStatus(HttpStatus.OK)
	public List<CategoryResponse.GetOne> getCategories() {
		return categoryService.getCategories();
	}

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	public List<CategoryResponse.GetOne> getCategoriesByTransactionType(@RequestParam String type) {
		return categoryService.getCategoriesByTransactionType(type);
	}

	@GetMapping("/subcategory")
	public List<CategoryResponse.GetOne> getSubcategories(@RequestParam Integer parentCategoryId) {
		return categoryService.getSubcategories(parentCategoryId);
	}
}
