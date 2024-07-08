package com.newdeal.ledger.sample.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.newdeal.ledger.sample.dto.SampleDto;

@Mapper
public interface SampleMapper {
	List<SampleDto> findAll();

	SampleDto findById(Long id);

	void insert(SampleDto sample);

	void update(SampleDto sample);

	void deleteById(Long id);
}
