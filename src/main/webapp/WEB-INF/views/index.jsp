<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	${msg} <!-- model 에서 보내온 msg 값 -->
	<h3>commit 한 내용을 취소하고 싶다면</h3>
	<p>1.브렌치 초기화 - 특정 지점까지 초기화 하는 기능</p>
	<p>2.revese commit</p>
	<p>불필요한 내용</p>	
	<button onclick="test()">클릭해주세요</button>
</body>
<script>
	var arr = [];
	var obj = {};
	
	function test() {
		alert('test 입니다.');
	}
</script>
</html>