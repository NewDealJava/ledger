package com.newdeal.ledger.categorytag.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.newdeal.ledger.categorytag.dto.CategoryDto;
import com.newdeal.ledger.categorytag.dto.TagDto;

@Mapper
public interface TagMapper {

	List<TagDto> findAllByEmail(String email);

}
