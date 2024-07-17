package com.newdeal.ledger.inquiry.mapper;// package com.newdeal.ledger.inquiry.mapper;

 import com.newdeal.ledger.inquiry.dto.CommentDto;
 import com.newdeal.ledger.inquiry.dto.InquiryDto;
 import org.apache.ibatis.annotations.Mapper;
 import org.apache.ibatis.annotations.Param;
 import org.springframework.web.bind.annotation.RequestParam;

 import java.util.ArrayList;
 import java.util.HashMap;

@Mapper
 public interface InquiryMapper {
     //1.문의 게시판_전체리스트 가져오기.
     ArrayList<InquiryDto> iSelectAll(@Param("startContRowNum") int startContRowNum, @Param("endContRowNum") int endContRowNum, @Param("searchCategory") String searchCategory, @Param("searchWord") String searchWord); //문의 게시판 전체리스트 가져오기
    //HashMap<Object, Object> map
     // ※ 문의 게시판_리스트 총갯수
     int iSelectCountAll(@Param("searchCategory") String searchCategory, @Param("searchWord") String searchWord);
     
     // 2.문의 게시판_게시글 1개 가져오기.
     InquiryDto iSelectOne(int qbno);
     void iHitUp(int qbno);// ← 게시글 조회수 증가

     // 3.문의 게시판_게시글 1개 작성하기(feat.파일 업로드)
     void iWrite(InquiryDto ibdto);

     // 4.문의 게시판_게시글 1개 삭제하기
     void iDelete(int qbno);

     // 5.문의 게시판_게시글 1개 수정하기
     void iDoUpdate(InquiryDto inquiryDto);
     
     // 6. 문의 게시판_하단댓글 모두 가져오기
     ArrayList<CommentDto> iCommentSelectAll(int qbno);
     // ※ 6-ⓐ. 문의 게시판_하단댓글 모두 가져오기
     int iCommentContSelectAll(int qbno);



}//InquiryMapper
