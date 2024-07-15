package com.newdeal.ledger.categorytag.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.categorytag.dto.TagDto;
import com.newdeal.ledger.categorytag.dto.TagRequest;
import com.newdeal.ledger.categorytag.mapper.TagMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TagServiceImpl implements TagService {
	private final TagMapper mapper;

	public List<TagDto> selectAllByEmail(String email) {
		return mapper.findAllByEmail(email);
	}

	public void createTag(String email, TagRequest.Create request) {
		mapper.createTag(email, request);
	}

	public void updateTag(Integer tagId, TagRequest.Update request) {
		mapper.updateTag(tagId, request);
	}

}
