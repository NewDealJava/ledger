package com.newdeal.ledger.categorytag.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.categorytag.dto.TagDto;
import com.newdeal.ledger.categorytag.dto.TagRequest;

@Mapper
public interface TagMapper {

	List<TagDto> findAllByEmail(String email);

	Integer createTag(@Param("email") String email, @Param("request") TagRequest.Create request);

}
