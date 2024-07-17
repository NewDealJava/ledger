package com.newdeal.ledger.user.service;

import com.newdeal.ledger.user.dto.UserDto;

public interface UserService {

	UserDto signUp(UserDto dto);

	UserDto signIn(UserDto requestDto);

	boolean findByEmail(String email);
}
