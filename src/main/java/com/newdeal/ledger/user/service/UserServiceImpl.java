package com.newdeal.ledger.user.service;

import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.newdeal.ledger.global.exception.LedgerAPIException;
import com.newdeal.ledger.global.exception.ResourceNotFoundException;
import com.newdeal.ledger.user.dto.UserDto;
import com.newdeal.ledger.user.mapper.UserMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
	private final UserMapper userMapper;

	private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	@Override
	public boolean findByEmail(String email) {
		UserDto dto = userMapper.findByEmail(email);
		return dto != null;
	}

	@Override
	public UserDto signUp(UserDto dto) {
		if (userMapper.existsByPhone(dto.getPhone())) {
			throw new LedgerAPIException(HttpStatus.BAD_REQUEST, "해당 휴대전화 번호가 이미 존재합니다.");
		}

		if (dto.getProfileImage() == null) {
			dto.setProfileImage("https://secure.gravatar.com/avatar/9cf19c0c46550fd0007486e412c2edd5?s=24&d=mm&r=g");
		}

		String password = dto.getPassword();
		String encodedPassword = passwordEncoder.encode(password);
		dto.setPassword(encodedPassword);

		userMapper.save(dto);

		return dto;
	}

	@Override
	public UserDto signIn(UserDto requestDto) {
		String email = requestDto.getEmail();
		UserDto responseDto = userMapper.findByEmail(email);

		if (responseDto == null) {
			throw new ResourceNotFoundException("해당 이메일은 존재하지 않습니다.");
		}

		String password = requestDto.getPassword();
		String encodedPassword = responseDto.getPassword();

		boolean isMatched = passwordEncoder.matches(password, encodedPassword);

		if (!isMatched) {
			throw new LedgerAPIException(HttpStatus.BAD_REQUEST, "이메일 혹은 비밀번호가 일치하지 않습니다.");
		}

		return responseDto;
	}

}
