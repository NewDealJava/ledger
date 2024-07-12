package com.newdeal.ledger.user.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.newdeal.ledger.user.dto.UserDto;

@Mapper
public interface UserMapper {
	void insert(UserDto user);

	boolean existsByEmail(String email);

	UserDto findByEmail(String email);
}
