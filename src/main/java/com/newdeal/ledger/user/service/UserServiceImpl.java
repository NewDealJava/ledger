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

	public void signUp(UserDto user) {

		try {
			String email = user.getEmail();
			String encodedPassword = passwordEncoder.encode(user.getPassword());
			boolean existsByEmail = userMapper.existsByEmail(email);
			if (existsByEmail)
				return;
			if (user.getRole() == null) {
				user.setRole("USER");
			}
			// if (user.getProfileImage() == null) {
			// user.setProfileImage("resources/static/img/default-profile-image.png");
			// }

			user.setPassword(encodedPassword);

		} catch (Exception e) {

			e.printStackTrace();
			return;
		}

		userMapper.insert(user);
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
