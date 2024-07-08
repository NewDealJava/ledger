package com.newdeal.ledger.sample.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class SampleDto {
	private Long id;
	private String title;
	private String content;
}
