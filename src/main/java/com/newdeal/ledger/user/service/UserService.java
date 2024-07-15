package com.newdeal.ledger.user.service;

import com.newdeal.ledger.user.dto.UserDto;

public interface UserService {

	boolean signUp(UserDto user);

	boolean findByEmail(String email);

	boolean matchesPassword(String rawPassword, String encodedPassword);

	UserDto selectByEmail(String email);

}
