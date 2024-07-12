package com.newdeal.ledger.categorytag.service;

import java.util.List;

import com.newdeal.ledger.categorytag.dto.TagDto;

public interface TagService {
	List<TagDto> selectAllByEmail(String email);
}
