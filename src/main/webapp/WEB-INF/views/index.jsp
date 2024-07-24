<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원리스트</title>
	</head>
	<!-- ♣♣♣ CSS1 ♣♣♣ -->
	<link href="../css/index.css" rel="stylesheet">
	
	<!-- ♣♣♣ font ♣♣♣ -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<!-- JQuery 최신 -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<!--◁◀◁◀ Header ▶▷▶▷ -->
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<!--◁◀◁◀ Header ▶▷▶▷ -->
	
	<script>
		$(function(){
			//전역변수
			var selectAll_state =0; //전체선택(0:전체선택이 안됨, 1:전체선택임 됨)
			
			$("#reloadBtn").click(function(){
				location.reload(true);//새로고침
			});//#reloadBtn(새로고침)
			
			//2. 삭제버튼
			$("#listDelBtn").click(function(){
			    if(confirm("삭제 하시겠습니까?")){
			        var YmnoArray = []; // ymno를 담을 배열을 생성합니다.
			            var ymno = $(this).closest("tr").find("#Ymno").val(); // 각 체크된 행에서 번호를 가져옵니다.
			            alert(ymno);
			    } // if-confirm(삭제) 종료
			}); // #listDeltBtn(삭제버튼) 종료
			
			//3.전체선택
			$("#SelectAll").click(function(){

			    if(selectAll_state == 0){
			        $(".chkBoxYmno").prop("checked", true);
			        selectAll_state = 1;
			    } else if(selectAll_state == 1){
			        $(".chkBoxYmno").prop("checked", false);
			        selectAll_state = 0;
			    }//if-else(리스트 전체선택 & 전체해제)
			});//#SelectAll(전체선택)
			
			//4.성별선택(전체선택, 남자, 여자)
			$("input[name=gender]").on("change",function(){
				
				//alert($("input[name=gender]:checked").val());	
				SearchFrm.submit();
			});//#AllGender(성별선택 <전체, 남자, 여자>)
			
			//5.게시글 갯수 선택
			$("#ViewCondition").on("change", function(){
				
				SearchFrm.submit();
			});//#ViewCondition(게시글 갯수 선택)
			
			$("#searchBtn").click(function(){
				
				if($("#searchWord").val().length<1){
					alert("※ 검색어를 입력해주세요.");
					$("#searchWord").focus();
					return false;
				}//if(검색어 미입력시)
				
				SearchFrm.submit();
				 
			});//#searchBtn(검색어)
			
			//검색어 유지
			var SearchWord_Maintain = $("#searchWord_maintain").val();
			$("#searchWord").val(SearchWord_Maintain);
			
		});//제이쿼리 최신
	</script>
	<body>
		<!--▼▼▼ 회원정보 리스트 전체테두리 ▼▼▼ -->
		<div class="table-container">
		<h1 style="font-size: 50px; font-weight: 700; position: relative; width: 420px; height: 20px;">문의(Q&A) 게시판</h1>
		
		<!--검색어 찾기 -->
		<div id="search-container">
			<form action="index" method="get" name="SearchFrm" style="width: 100%; display: flex; justify-content: space-between;">
				<div id="seletBox" style="width: 280px; padding-top: 50px;">
					<input type="radio" id="AllGender" value="allGen" name="gender" style="display: inline-block; vertical-align: middle;"><label for="all" >전체</label>
					<input type="radio" id="Male" value="male" name="gender" style="display: inline-block; vertical-align: middle;"><label for="male">답변대기</label>
					<input type="radio" id="Female" value="female" name="gender" style="display: inline-block; vertical-align: middle;"><label for="female" >답변완료</label>
				</div>
				<div id="searchSection">
					<select id="ViewCondition" name="ViewColumnsCount">
						<option value="5" selected="selected">5 개</option>
						<option value="5" >10 개</option>
						<option value="5" >15 개</option>
						<option value="5" >20 개</option>
					</select>
					<select id="searchCategory" name="SearchCategory">
						<option value="All" selected="selected">전체</option>
						<option value="qtitle">제목</option>
						<option value="qcontent">내용</option>
						<option value="Id">아이디</option>
					</select>
					<input type="text" id="searchWord" name="SearchWord" placeholder=" ※검색어를 입력하세요.">
					<input type="hidden" id="searchWord_maintain" value="${map.SearchWord }">
					<input type="button" id="searchBtn" value="검 색">
				</div>
			</form>
		</div>
		<!--검색어 찾기 끝 -->
		
		<hr style="border: 2px solid blue; margin-bottom: 20px;">
		  <table style="border-top: 5px solid blue;">
		    <thead>
			    <colgroup>
				    <col width="7%">
				    <col width="63%">
				    <col width="10%">
				    <col width="10%">
				    <col width="10%">
			    </colgroup>
			      <tr>
			        <th>게시판 번호</th>
			        <th>제목</th>
			        <th>작성자</th>
			        <th>문의상태</th>
			        <th>게시일</th>
			      </tr>
		    </thead>
		    <tbody style="border-bottom: 5px solid blue;">
                <c:forEach var="ibdto" items="${map.list}">
                      <tr>
                        <td>${ibdto.qbno}</td>
                        <td>${ibdto.qtitle}</td>
                        <td>${ibdto.email}</td>
                        <c:if test="${ibdto.qstatus==0}">
                            <td style="font-weight: 700; color: red; text-align : center">답변대기</td>
                        </c:if>
                        <c:if test="${ibdto.qstatus==1}">
                            <td style="font-weight: 700; color: blue;  text-align : center">답변완료</td>
                        </c:if>
                       <td><fmt:formatDate value="${ibdto.qdate}" pattern="YYYY-MM-dd"/> </td>
                      </tr>
                  </c:forEach>
		    </tbody>
		  </table>
		  
		  <!--페이지 넘버링 시작 -->
		  <ul id="PageNum" style="display: flex; list-style: none;">
		  	
		  	<!--첫번째 페이지-->
		  	<a href="#"><li class="num"><i class="fa fa-backward" aria-hidden="true"></i></li></a>
		  	<!--이전 페이지-->
	  		<li class="num"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i></li>
		  	
		  	<!--페이지 넘버링-->
		  	<c:forEach var="i" begin="${map.startPageNum}" end="${map.endPageNum }" step="1">
		  	    <a href="#" style="text-decoration: none;"><li class="num">${i}</li></a>
		  	</c:forEach>
		  	<!--페이지 넘버링-->
		  	
		  	<!--다음 페이지-->
	  		<li class="num"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i></li>
		  	<!-- 마지막 페이지 -->
	  		<li class="num"><i class="fa fa-forward" aria-hidden="true"></i></li>
		  </ul>
		  <!--페이지 넘버링 끝 -->
		
			<!--▣ 버튼 ▣ -->
			<div class="button-container">
			  <input type="button" id="reloadBtn" value="Home">
			  <input type="button" id="listDelBtn" value="삭제">
			</div>
			<!--▣ 버튼 ▣-->
		</div>
		<!-- ▲▲▲ 회원정보 리스트 전체 테두리 끝 ▲▲▲-->
	</body>
	
	<!--◁◀◁◀ Footer ▶▷▶▷ -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<!--◁◀◁◀ Footer ▶▷▶▷ -->
</html>