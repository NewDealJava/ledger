package com.newdeal.ledger.categorytag.service;

import java.util.List;

import com.newdeal.ledger.categorytag.dto.TagDto;
import com.newdeal.ledger.categorytag.dto.TagRequest;

public interface TagService {
	List<TagDto> selectAllByEmail(String email);

	void createTag(String email, TagRequest.Create request);

	void updateTag(Integer tagId, TagRequest.Update request);
}
