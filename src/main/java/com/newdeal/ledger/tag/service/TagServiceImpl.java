package com.newdeal.ledger.tag.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.tag.dto.TagDto;
import com.newdeal.ledger.tag.dto.TagRequest;
import com.newdeal.ledger.tag.mapper.TagMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TagServiceImpl implements TagService {
	private final TagMapper mapper;

	@Override
	public void createTag(String email, TagRequest.Create request) {
		mapper.createTag(email, request);
	}

	@Override
	public void updateTag(Integer tagId, TagRequest.Update request) {
		mapper.updateTag(tagId, request);
	}

	@Override
	public void removeTag(Integer tagId) {
		mapper.deleteTransactionTagByTagId(tagId);
		mapper.deleteTag(tagId);
	}

	@Override
	public List<TagDto> getTagsByEmail(String email) {
		return mapper.findTagsByEmail(email);
	}
}
