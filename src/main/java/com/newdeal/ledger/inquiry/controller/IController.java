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
 	public String index(@RequestParam(name ="page", defaultValue = "1" ) int page, Model model) {

		// ▽ Service에 연결
 		Map<String, Object> map = inquiryService.iSelectAll(page);

 		// ▼ model저장 후 전송
 		model.addAttribute("map",map);


 		return "/inquiry";
 	}//index

	// 2.문의 게시판_게시글 1개 가져오기
	@GetMapping ("/iView")
	public String iView(@RequestParam (defaultValue = "1") int qbno, Model model){

	 	// ▽ Service에 연결
		InquiryDto ibdto = inquiryService.iSelectOne(qbno);

		// ▼ model저장 후 전송
		model.addAttribute("ibdto",ibdto);

		 return "/iView";
	}//iView(qbno, model)

	//3. 문의 게시판_게시글 작성 페이지
	@GetMapping ("/iWrite")
	public String iWrite (){
		 return "/iWrite";
	}//iWrite : 문의 게시찬_게시글 작성 페이지

	// 3-ⓐ. 문의 게시판_게시글 1개 작성하기(feat.파일 업로드)
	@PostMapping("/iWrite")
	public String iWrite (InquiryDto ibdto, @RequestParam MultipartFile qFile ,Model model) throws Exception {
		 
		 // ★ 파일업로드 부분
		if(!qFile.isEmpty()){
			String oriFName = qFile.getOriginalFilename();
			long time = System.currentTimeMillis();
			String upFName = time + "_" + oriFName;
			String fupload = "c:/upload/";

			// ↓ 파일업로드 부분
			File f = new File(fupload + upFName);
			qFile.transferTo(f);

			// ↓ ibdto ifile추가
			ibdto.setQfile(upFName);
		} else {
			ibdto.setQfile(""); //파일이
		} // if-else(게시글 작성하기 파일있는 경우 else 없는경우)

		// service연결 - 파일저장
		inquiryService.iWrite(ibdto);


		// ▼ model저장 후 전송
		model.addAttribute("result","iWrite-Save");


		 return "/iResult";
	}//iWrite(ibdto, model)

	// 4. 문의 게시판_게시글 1개 삭제하기
	@PostMapping("/iDelete")
	public String iDelete(@RequestParam(defaultValue = "1") int qbno, Model model){

		// ▽ Service에 연결
		inquiryService.iDelete(qbno);

		// ▼ model저장 후 전송
		model.addAttribute("result","iView-Delete");

		 return "/iResult";
	}//iDelete(qbno, model)



 }//IController