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
 	private Timestamp qdate;
 	private String qfile;
    private int qhit;
    private int commentCount; // 댓글 개수


     // 생성자, getter, setter 메서드 등은 필요에 따라 추가 정의
     public int getCommentCount() {
         return commentCount;
     } //댓글 갯수

     public void setCommentCount(int commentCount) {
         this.commentCount = commentCount;
     }//댓글 갯수
 }//inquiryDto
