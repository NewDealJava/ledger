package com.newdeal.ledger.inquiry.service;// package com.newdeal.ledger.inquiry.service.impl;

 import com.newdeal.ledger.inquiry.dto.CommentDto;
 import com.newdeal.ledger.inquiry.dto.InquiryDto;
 import com.newdeal.ledger.inquiry.mapper.InquiryMapper;
 import org.springframework.stereotype.Service;
 import org.springframework.transaction.annotation.Transactional;

 import java.util.ArrayList;
 import java.util.HashMap;
 import java.util.Map;

@Service
 public class InquiryServiceImpl implements InquiryService {

     //@Autowired InquiryMapper inquiryMapper;
     public InquiryMapper inquiryMapper;

     // ▼ (스프링 의존성 주입 방식 : 생성자 주입 방식)
     public  InquiryServiceImpl (InquiryMapper inquiryMapper){
         this.inquiryMapper=inquiryMapper;
     }//생성자 주입 방식.gi

     // 1. 문의 게시판_전체리스트 가져오기
     @Override
     public Map<String, Object> iSelectAll(int page, String searchCategory, String searchWord) {

         //1. 페이지 넘버링 - ②번째
         if(page <=0)
             page = 1;
         int contentCount = 10; //1Pg당 게시글 갯수
         int bottomArray = 10; //하단 페이지 넘버링 수
         int countAll = inquiryMapper.iSelectCountAll(searchCategory,searchWord);
         int maxPage = (int) Math.ceil((double) countAll /contentCount); //게시글 최대페이지
         int startPageNum = ((page - 1) / bottomArray) * bottomArray + 1; //게시글 시작페이지
         int endPageNum = (startPageNum + bottomArray) - 1; //게시글 마지막 페이지
         if (endPageNum > maxPage) // *페이지 넘버링 최대페이지가 끝페이지보다 작을경우
             endPageNum = maxPage;
         int startContRowNum = (page - 1) * contentCount; //page 시작 게시판 번호
         int endContRowNum = startContRowNum + contentCount - 1; // page 마지막 게시판 번호
         System.out.println("pg당 첫번째 : "+startContRowNum);
         System.out.println("pg당 마지막째 : "+endContRowNum);

         //2.문의 게시판 전체리스트 가져오기 - ①번째
         ArrayList<InquiryDto> list = inquiryMapper.iSelectAll(startContRowNum,endContRowNum,searchCategory,searchWord);

        // ③번째 - Return 타입을 ArrayList에서 Map으로 변경 → Map에서 태워서 jsp로 보내기
         Map<String, Object> map = new HashMap<>();
         map.put("list",list);
         map.put("page",page);
         map.put("maxPage",maxPage);
         map.put("startPageNum",startPageNum);
         map.put("endPageNum",endPageNum);

         map.put("searchWord",searchWord);
         map.put("searchCategory",searchCategory);

         // 각 게시글의 댓글 개수 가져오기 및 Map에 추가
         for (InquiryDto ibdto : list) {
             int qbno = ibdto.getQbno(); // 각 게시글의 고유 번호
             int iCommentCountNum = inquiryMapper.iCommentContSelectAll(qbno); // 댓글 개수 가져오기
             ibdto.setCommentCount(iCommentCountNum); // InquiryDto에 댓글 개수 설정
         } //해당 게시글 댓글 갯수
         return map;
     }//iSelectAll(page)

    // 2. 문의 게시판_게시글 1개 가져오기
    @Override
    public Map<String, Object> iSelectOne(int qbno) {
        // ※ mapper연결
        InquiryDto inquiryDto = inquiryMapper.iSelectOne(qbno); //문의 게시판 - 게시글 1개 가져오기
        inquiryMapper.iHitUp(qbno);  //조회수 1증가
        ArrayList<CommentDto> iCommentlist = inquiryMapper.iCommentSelectAll(qbno);
        int iCommentCountNum = inquiryMapper.iCommentContSelectAll(qbno); // 댓글 개수

        // ▼ Map으로 전송
        Map<String, Object> map = new HashMap<>();
        map.put("ibdto",inquiryDto);
        map.put("iCommentlist",iCommentlist);
        map.put("iCommentCountNum",iCommentCountNum);

        return map;
    }// iSelectOne(qbno)

    // 3. 문의 게시판_게시글 1개 작성하기(feat.파일 업로드)
    @Override
    @Transactional
    public void iWrite(InquiryDto ibdto) {
         // ※ mapper 연결
         inquiryMapper.iWrite(ibdto);
        System.out.println("mapper qcontent : "+ibdto.getQcontent());
    }//iWrite(ibdto)

    // 4. 문의 게시판_게시글 1개 삭제하기
    @Override
    public void iDelete(int qbno) {
         // ※ mapper 연결
        inquiryMapper.iDelete(qbno);
    }// iDelete(qbno)

    // 5. 문의 게시판_게시글 1개 수정하기
    @Override
    public void iDoUpdate(InquiryDto inquiryDto) {
        // ※ mapper 연결
        inquiryMapper.iDoUpdate(inquiryDto);
    }//iDoUpdate(inquiryDto)


}//InquiryServiceImpl //서비스 임플
