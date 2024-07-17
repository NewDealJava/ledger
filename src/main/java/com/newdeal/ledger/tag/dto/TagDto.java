package com.newdeal.ledger.tag.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TagDto {
	public Integer tagId;
	public String email;
	public String name;
}
