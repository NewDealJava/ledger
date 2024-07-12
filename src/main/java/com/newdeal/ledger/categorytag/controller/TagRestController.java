package com.newdeal.ledger.categorytag.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.categorytag.dto.TagDto;
import com.newdeal.ledger.categorytag.service.TagService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value = "/api/tag")
@RequiredArgsConstructor
public class TagRestController {
	private final TagService tagService;

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	public List<TagDto> getAllTagsByEmail() {
		String tempEmail = "user1@example.com";
		return tagService.selectAllByEmail(tempEmail);
	}
}
