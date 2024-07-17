package com.newdeal.ledger.inquiry.service;// package com.newdeal.ledger.inquiry.service;

 import com.newdeal.ledger.inquiry.dto.InquiryDto;

 import java.util.Map;

public interface InquiryService {

 	// ▶ 1.문의 게시판 전체 리스트 가져오기
 	Map<String, Object> iSelectAll(int page, String searchCategory, String searchWord);

    // ▶ 2.문의 게시판_게시물 1개 가져오기
    Map<String, Object> iSelectOne(int qbno);

    // ▶ 3.문의 게시판_게시물 1개 작성하기(feat.파일업로드)
    void iWrite(InquiryDto ibdto);

    // ▶ 4.문의 게시판_게시물 1개 삭제하기
    void iDelete(int qbno);

    // ▶ 5.문의 게시판_게시물 1개 수정하기
    void iDoUpdate(InquiryDto inquiryDto);
}//InquiryService //서비스
