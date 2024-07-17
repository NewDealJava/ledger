package com.newdeal.ledger.tag.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.newdeal.ledger.tag.dto.TagDto;
import com.newdeal.ledger.tag.dto.TagRequest;

@Mapper
public interface TagMapper {
	Integer createTag(@Param("email") String email, @Param("request") TagRequest.Create request);

	Integer updateTag(@Param("tagId") Integer tagId, @Param("request") TagRequest.Update request);

	void deleteTag(Integer tagId);

	List<TagDto> findTagsByEmail(String email);

	void deleteTransactionTagByTagId(Integer tagId);

}
