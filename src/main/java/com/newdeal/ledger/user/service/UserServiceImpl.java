package com.newdeal.ledger.user.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.newdeal.ledger.user.dto.UserDto;
import com.newdeal.ledger.user.mapper.UserMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
	private final UserMapper userMapper;

	private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	public boolean signUp(UserDto dto) {

		try {
			String email = dto.getEmail();
			String encodedPassword = passwordEncoder.encode(dto.getPassword());
			boolean existsByEmail = userMapper.existsByEmail(email);
			if (existsByEmail)
				return false;
			if (dto.getRole() == null) {
				dto.setRole("USER");
			}
			dto.setPassword(encodedPassword);
			userMapper.insert(dto);
		} catch (Exception e) {

			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean findByEmail(String email) {
		UserDto dto = userMapper.findByEmail(email);
		return dto != null;
	}

	@Override
	public boolean matchesPassword(String rawPassword, String encodedPassword) {
		return passwordEncoder.matches(rawPassword, encodedPassword);
	}

	@Override
	public UserDto selectByEmail(String email) {
		return userMapper.findByEmail(email);
	}

}
