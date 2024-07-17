package com.newdeal.ledger.tag.service;

import java.util.List;

import com.newdeal.ledger.tag.dto.TagDto;
import com.newdeal.ledger.tag.dto.TagRequest;
import com.newdeal.ledger.tag.dto.TagResponse;

public interface TagService {
	void createTag(String email, TagRequest.Create request);

	void updateTag(Integer tagId, TagRequest.Update request);

	void removeTag(Integer tagId);

	List<TagResponse.GetOne> getTagsByEmail(String email);
}
