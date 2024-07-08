package com.newdeal.ledger.inquiry.dto;// package com.newdeal.ledger.inquiry.dto;

 import lombok.AllArgsConstructor;
 import lombok.Builder;
 import lombok.Data;
 import lombok.NoArgsConstructor;

 import java.sql.Timestamp;

 @Builder
 @AllArgsConstructor
 @NoArgsConstructor
 @Data
 public class InquiryDto {

 	private int qbno;
 	private String email;
 	private String qtitle;
 	private String qcontent;
 	private int qstatus;
 	private Timestamp qdate;
 	private String qfile;

 }//inquiryDto
