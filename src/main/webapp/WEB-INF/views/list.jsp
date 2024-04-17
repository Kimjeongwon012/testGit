<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>
<body>
	게시판 리스트
	<hr/>
	<button onclick="del()">선택 삭제</button>
	<table>
		<!-- thead 는 머리글 태그이다 -->
		<thead>
			<tr>
				<th><input type="checkbox" id="all"/></th>
				<th>글번호</th>
				<th>이미지</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>날짜</th>
			</tr>
		</thead>
		<!-- append 하나하나 넣기 때문에 멈춰버리면 뚝 끊겨서 그려진다 -->
		<!-- html 은 완전히 잘그려지던지 아니던지(추천) -->
		<tbody id="list">
			
		</tbody>
<%-- 		<c:forEach items="${list}" var="item">
			<tr>
				<td><input type="checkbox" name="del" value="${item.idx}"/></td>
				<td>${item.idx}</td>
				<td>
					<c:if test="${item.img_cnt>0}"><img class="icon" src="resources/img/image.png"/></c:if>
					<c:if test="${item.img_cnt==0}"><img class="icon" src="resources/img/no_image.png"/></c:if>
				</td>
				<td>${item.subject}</td>
				<td>${item.user_name}</td>
				<td>${item.bHit}</td>
				<td>${item.reg_date}</td>
			</tr>
		</c:forEach> --%>		
	</table>
</body>
<script>
	// </html> 까지 모두 읽히고나면(준비되면) 아래의 내용을 실행해라
	// body 밑에다가 쓰면 문제 없다
	// 옛날 코드에서 스크립트를 위에다가 두기 때문에 많이 보인다
	// 하지만 이제는 스크립트를 아래에다가 두기 때문에 상관없다
	$(document).ready(function() {
		listCall();
	});
	
	$("#all").click(function() {
		//console.log($(this).is(":checked"));
		
		var $chk = $("input[name='del']");
		
		// 내가 실행하려는 시점보다 반드시 '먼저' 그려져 있어야한다 
		// attr : 정적 속성, 처음부터 그려져 있거나 jsp 에서 그린 내용
		// prop : 동적 속성, 자바스크립트로 나중에 그려진 내용 
		if ($(this).is(":checked")) {
			$chk.prop('checked', true);
		} else {
			$chk.prop('checked', false);	
		}
		
	    //$("input[name='del']").prop('checked', $(this).prop('checked'));
	});
	
    // AJAX 를 이용한 비동기 통신
    // JS 에서는 Object 는 문자열 key-value 사용할 수 있고
    // 배열은 인덱스로 접근할 수 있다
    // 순서는 상관없지만 어디로 보내 어떤 파라미터를 보내 성공시 어떻게? 실패시 어떻게?
	function listCall() {
	    $.ajax({
	        type:'post' // method 방식
	        ,url:'./list.ajax' // 요청할 주소 // 파라미터 
	        ,data:{}
	    	,dataType:'json' // 기본 데이터 타입은 JSON 이다
	        ,success:function(data){ // 성공했을 경우
	            // AJAX 에서 XmlHttpRequest 객체를 통해 대신 받아와서
	            // 여기에 뿌려준다
	        	// console.log(data.list);
	        	drawList(data.list);
	        } 
	        ,error:function(error){ // 통신 실패한 경우
	            console.log(error);
	        }
	    });
    }

    // 체크 표시된 게시글들의 번호들을 delArr 에 담아보자
	function del() {
    	var delArr = [];
    	$("input[name='del']").each(function(index, item) {
			if ($(item).is(":checked")) {
				var val = $(this).val();
				console.log(val);
				delArr.push(val);
			}
		});
    	
        $.ajax({
            type:'post' // method 방식
            ,url:'./del.ajax' // 요청할 주소 // 파라미터 
            ,data:{delList:delArr}
        	,dataType:'json' // 기본 데이터 타입은 JSON 이다
            ,success:function(data){ // 통신 성공할 경우
            	if (data.cnt > 0) {
            		alert('선택하신 ' + data.cnt + '개의 글이 삭제되었습니다');
            		$('#list').empty();
            		listCall();
            	}
            	console	.log(data);
            } 
            ,error:function(error){ // 통신 실패한 경우
                console.log(error);
            }
        });
    	console.log('delArr:', delArr);
    }
    
    // 요청받은 List<BoardDTO> list 를 페이지에 그린다
    function drawList(list) {
    	var content = '';
    	
    	for (item of list) {
    		console.log(item);
    		content +='<tr>';
   			content +='<td><input type="checkbox" name="del" value="'+ item.idx +'"/></td>';
			content +='<td>'+ item.idx +'</td>';
			content +='<td>';
			var  img = item.img_cnt > 0 ? 'image.png' : 'no_image.png';
			content +='<img class="icon" src="resources/img/' + img + '"/>';
			content +='</td>';
			content +='<td>' + item.subject +'</td>';
			content +='<td>' + item.user_name +'</td>';
			content +='<td>' + item.bHit + '</td>';
			
			//content +='<td>' + item.reg_date + '</td>';
			// java.sql.Date 는  javascript 에서는 밀리세컨드로 변환하여 표시한다
			// 방법 1. 백엔드에서 해결 - DTO의 변환 날짜 타입을 문자열로 변경한다 (서버를 껏다 켜야하는 큰 약점이 있다)
			//	public String getReg_date() {
			//		return reg_date.toString();
			//	}
			// 방법 2. 프론트엔드에서 해결
			// content +='<td>' + item.reg_date + '</td>';
			var date = new Date(item.reg_date);
			var dateStr = date.toLocaleDateString('ko-KR'); // en-US, 언어-국가
			console.log(date);
			content +='<td>' + dateStr + '</td>';
			content +='</tr>';
 		}
    	
    	$('#list').html(content);
    }
</script>
</html>