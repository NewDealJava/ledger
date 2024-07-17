package com.newdeal.ledger.tag.service;

import java.util.List;

import com.newdeal.ledger.tag.dto.TagDto;
import com.newdeal.ledger.tag.dto.TagRequest;

public interface TagService {
	void createTag(String email, TagRequest.Create request);

	void updateTag(Integer tagId, TagRequest.Update request);

	void removeTag(Integer tagId);

	List<TagDto> getTagsByEmail(String email);
}
