package com.newdeal.ledger.user.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.newdeal.ledger.user.dto.UserDto;

@Mapper
public interface UserMapper {

	UserDto findByEmail(String email);

	boolean existsByPhone(String phone);

	void save(UserDto dto);
}
