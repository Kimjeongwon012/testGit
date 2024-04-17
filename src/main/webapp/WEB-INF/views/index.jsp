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
	<p>2.revese commit - 특정 커밋 에서 실행한 내용을 취소하고, 이후 내용은 유지하고 싶을때 사용</p>
</body>
</html>