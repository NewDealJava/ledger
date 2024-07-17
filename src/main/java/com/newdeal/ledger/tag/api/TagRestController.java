package com.newdeal.ledger.tag.api;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.newdeal.ledger.tag.dto.TagDto;
import com.newdeal.ledger.tag.dto.TagRequest;
import com.newdeal.ledger.tag.dto.TagResponse;
import com.newdeal.ledger.tag.service.TagService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping(value = "/api/tag")
@RequiredArgsConstructor
public class TagRestController {
	private final TagService tagService;

	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	public void createTag(@ModelAttribute TagRequest.Create request) {
		String tempEmail = "user1@example.com";
		tagService.createTag(tempEmail, request);
	}

	@PutMapping(value = "/{tagId}")
	@ResponseStatus(HttpStatus.OK)
	public void updateTag(@PathVariable Integer tagId, @RequestBody TagRequest.Update request) {
		tagService.updateTag(tagId, request);
	}

	@DeleteMapping(value = "/{tagId}")
	@ResponseStatus(HttpStatus.OK)
	public void removeTag(@PathVariable Integer tagId) {
		tagService.removeTag(tagId);
	}

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	public List<TagResponse.GetOne> getTagsByEmail() {
		String tempEmail = "user1@example.com";
		return tagService.getTagsByEmail(tempEmail);
	}

}
