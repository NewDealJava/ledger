package com.newdeal.ledger.inquiry.controller;// package com.newdeal.ledger.inquiry.controller;

 import com.newdeal.ledger.inquiry.dto.InquiryDto;
 import com.newdeal.ledger.inquiry.service.InquiryService;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.stereotype.Controller;
 import org.springframework.ui.Model;
 import org.springframework.web.bind.annotation.GetMapping;
 import org.springframework.web.bind.annotation.PostMapping;
 import org.springframework.web.bind.annotation.RequestParam;
 import org.springframework.web.multipart.MultipartFile;

 import java.io.File;
 import java.io.IOException;
 import java.util.ArrayList;
 import java.util.Map;
 import java.util.Objects;

@Controller

 public class IController {
 	//@Autowired private InquiryService inquiryService; ← 스프링 의존성 주입방식 : 필드주입 방식
	// ▼ (스프링 의존성 주입방식 :  생성자 주입방식)
	private final InquiryService inquiryService;
	public IController(InquiryService inquiryService){
		this.inquiryService=inquiryService;
	} //생성자 주입방식

 	/**
 	 * 문의 게시판 페이지
 	 *
 	 * @return index 최창윤
 	 */
	 
	 // 1. 문의 게시판_전체 리스트 가져오기.
 	@GetMapping("/inquiry")
 	public String index(@RequestParam(name ="page", defaultValue = "1" ) int page, @RequestParam(name="SearchCategory", defaultValue = "All") String SearchCategory, @RequestParam(name = "SearchWord", required = false) String SearchWord,  Model model) {

		// ▽ Service에 연결
 		Map<String, Object> map = inquiryService.iSelectAll(page);

 		// ▼ model저장 후 전송
 		model.addAttribute("map",map);


 		return "/inquiry";
 	}//index

	// 2.문의 게시판_게시글 1개 가져오기
	@GetMapping ("/iView")
	public String iView(@RequestParam (name = "qbno", defaultValue = "1") int qbno, Model model){

	 	// ▽ Service에 연결
		Map<String, Object> map = inquiryService.iSelectOne(qbno);

		// ▼ model저장 후 전송
		model.addAttribute("map",map);

		 return "iView";
	}//iView(qbno, model)

	//3. 문의 게시판_게시글 작성하기 (페이지)
	@GetMapping ("/iWrite")
	public String iWrite (){
		 return "/iWrite";
	}//iWrite : 문의 게시찬_게시글 작성 페이지

	// 3-ⓐ. 문의 게시판_게시글 1개 작성하기(feat.파일 업로드)
	@PostMapping("/iDoWrite")
	public String iWrite (InquiryDto ibdto ,Model model) {
		System.out.println("Write Content : " + ibdto.getQcontent());

		// ▽ service연결 - 파일저장
		inquiryService.iWrite(ibdto);

		// ▼ model저장 후 전송
		model.addAttribute("result","iWrite-Save");


		 return "/doIBoard";
	}//iWrite(ibdto, model)

	// 4. 문의 게시판_게시글 1개 삭제하기
	@PostMapping("/iDelete")
	public String iDelete(@RequestParam(name = "qbno",defaultValue = "1") int qbno, Model model){

		System.out.println("qdel qbno : "+qbno);
		// ▽ Service에 연결
		inquiryService.iDelete(qbno);

		// ▼ model저장 후 전송
		model.addAttribute("result","iView-Delete");

		 return "/doIBoard";
	}//iDelete(qbno, model)

	// 5. 문의 게시판_게시글 1개 수정하기(페이지 이동)
	@PostMapping ("/iUpdate")
	public String iUpdate(@RequestParam (name = "qbno", defaultValue = "1") int qbno, Model model){

		// ▽ Service에 연결
		Map<String, Object> map = inquiryService.iSelectOne(qbno);

		// ▼ model저장 후 전송
		model.addAttribute("map",map);

		 return "iUpdate";
	}//iUpadte(qbno,model)

	// 5. 문의 게시판_게시글 1개 수정하기(수정작성)
	@PostMapping ("/iDoUpdate")
	public String iDoUpdate(InquiryDto inquiryDto, Model model){
		// ▽ service연결 - 게시글 수정
		inquiryService.iDoUpdate(inquiryDto);
		System.out.println("qvbno : "+inquiryDto.getQbno());
		System.out.println("qtitle: "+inquiryDto.getQtitle());

		// ▼ model저장 후 전송
		model.addAttribute("result","iUpdate-Save");

		 return "doIBoard";
	}//iDoUpdate(inquiryDto, model)


 }//IController