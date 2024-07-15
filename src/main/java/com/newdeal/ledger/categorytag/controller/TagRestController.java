package com.newdeal.ledger.categorytag.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.categorytag.dto.TagDto;
import com.newdeal.ledger.categorytag.dto.TagRequest;
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

	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	public void createTag(@ModelAttribute TagRequest.Create request) {
		String tempEmail = "user1@example.com";
		tagService.createTag(tempEmail, request);
	}

	@PutMapping(value = "/{tagId}")
	@ResponseStatus(HttpStatus.OK)
	public void updateTag(@PathVariable Integer tagId, @RequestBody TagRequest.Update request) {

		System.out.println("ddd");
		tagService.updateTag(tagId, request);
	}



}
