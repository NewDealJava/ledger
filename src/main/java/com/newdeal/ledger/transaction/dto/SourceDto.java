package com.newdeal.ledger.transaction.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class SourceDto {
	public SourceType sourceType;
	public SubSourceType subSourceType;
	public Integer sno;
	public String cname;
}
