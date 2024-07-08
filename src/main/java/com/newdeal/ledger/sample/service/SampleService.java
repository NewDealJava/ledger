package com.newdeal.ledger.sample.service;

import java.util.List;

import com.newdeal.ledger.sample.dto.SampleDto;

public interface SampleService {

	List<SampleDto> findAll();

	SampleDto findById(Long id);

	void save(SampleDto sample);

	void deleteById(Long id);
}
