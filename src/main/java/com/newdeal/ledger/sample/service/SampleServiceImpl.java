package com.newdeal.ledger.sample.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newdeal.ledger.sample.dto.SampleDto;
import com.newdeal.ledger.sample.mapper.SampleMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SampleServiceImpl implements SampleService {
	private final SampleMapper sampleMapper;

	public List<SampleDto> findAll() {
		return sampleMapper.findAll();
	}

	public SampleDto findById(Long id) {
		return sampleMapper.findById(id);
	}

	public void save(SampleDto sample) {
		if (sample.getId() == null) {
			sampleMapper.insert(sample);
		} else {
			sampleMapper.update(sample);
		}
	}

	public void deleteById(Long id) {
		sampleMapper.deleteById(id);
	}
}
