<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판 목록보기</title>
	<style>
		* {
			margin: 0 auto;
			padding: 0 auto;
			overflow: hidden;
		}
		td, h2 {
			text-align:center;
		}
	</style>
	
	<script src="https://code.jquery.com/js/jquery.3.6.0.min.js"></script>
</head>
<body>
	<h2>게시판 글목록</h2>
	 
	<div>
	    <table id="addList" width="500" cellpadding="0" cellspacing="0" border="1">
	        <thead>
	            <tr>
	                <th>번호</th>
					<th>이름</th>
					<th>제목</th>
					<th>날짜</th>
					<th>조회수</th>
	            </tr>
	        </thead>
	        <c:forEach var="dto" items="${ list }">
		        <tbody id="listBody">
			        <tr>
						<td>${ dto.board_idx }</td>
						<td>${ dto.board_name }</td>
						<td>
							<a href="contentForm?board_idx=${dto.board_idx}"> ${ dto.board_title } </a>
						</td>
						<td>
							<c:set var="dateVar" value="${ dto.board_date }" />
							<fmt:formatDate value="${dateVar}" pattern="yyyy-MM-dd" />
						</td>
						<td>${ dto.board_hit }</td>
					</tr>
		        </tbody>
		       </c:forEach>
	        
	        <tr>
				<td colspan="5"><button id="addBtn" onclick="moreList()"><span>더보기</span></button></td>
			</tr>
			<tr>
				<td colspan="5"><a href="writeForm">글작성</a></td>
			</tr>
	    </table>  
	</div>
	
	<script>
	function moreList() {
	 
		consol.log("moreList 호출")
	    var startNum = $("#listBody").length;  //마지막 리스트 번호를 알아내기 위해서 tr태그의 length를 구함.
	    var addListHtml = "";  
	    console.log("startNum 출력", startNum); //콘솔로그로 startNum에 값이 들어오는지 확인
	 
	     $.ajax({
	        url : "/listForm",
	        type : "post",
	        dataType : "json",
	        contentType: "application/json",
	        data : {'addlist'},
	        
	        success : function(data) {
	            if(data.length < 10){
	                $("#addBtn").remove();   
	            }else{
	            var addListHtml ="";
	            if(data.length > 0){
	                for(var i=0; i<data.length; i++) {
	                    var board_idx = Number(startNum)+Number(i)+1;   
	                    // 글번호 : startNum 이  10단위로 증가되기 때문에 startNum +i (+1은 i는 0부터 시작하므로 )
	                    addListHtml += "<tr>";
	                    addListHtml += "<td>"+ board_idx + "</td>";
	                    addListHtml += "<td>"+ board_name + "</td>";
	                    addListHtml += "<td>"+ board_title + "</td>";
	                    addListHtml += "<td>"+ board_date + "</td>";
	                    addListHtml += "<td>"+ board_hit + "</td>";
	                    addListHtml += "</tr>";
	                }
	                $("#listBody").append(addListHtml);
	            }
	            }
	        }
	    });
	 
	}
	</script>

	
</body>
</html>