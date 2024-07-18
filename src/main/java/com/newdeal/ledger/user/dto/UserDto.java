package com.newdeal.ledger.user.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {
  private String email;
  private String uuid;
  private String password;
  private String name;
  private String phone;
  private String address;
  private String profileImage;
  private Date createdAt;
  private String role;
}
