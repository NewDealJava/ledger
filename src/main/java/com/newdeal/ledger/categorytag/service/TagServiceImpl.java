package com.newdeal.ledger.categorytag.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.categorytag.dto.TagDto;
import com.newdeal.ledger.categorytag.mapper.TagMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TagServiceImpl implements TagService {
	private final TagMapper mapper;

	public List<TagDto> selectAllByEmail(String email) {
		return mapper.findAllByEmail(email);
	}
}
