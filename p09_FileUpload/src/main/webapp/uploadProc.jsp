<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>        
<%
//String saveFolder = "D:\\Java_Web_AI\\silsp\\jsp\\p09_FileUpload\\src\\main\\webapp\\fileStorage";

String saveFolder = application.getRealPath("/fileStorage");
int maxSize = 5*1024*1024;   // 5MByte 까지 최대 업로드 허용
String encType = "UTF-8";

String subject = "";
String content = "";

String originalFile = "";  // 원본 파일명
String uploadFile = "";    // 업로드된 파일명

int fileSize = 0;         // 파일 크기(=용량)

try {
	MultipartRequest multiReq = new MultipartRequest(
				request,
				saveFolder,
				maxSize,
				encType,
				new DefaultFileRenamePolicy()
			);

	subject = multiReq.getParameter("subject");
	content = multiReq.getParameter("content");
	
	originalFile = multiReq.getOriginalFileName("fileName");
	// 원본 파일명
	uploadFile = multiReq.getFilesystemName("fileName");
	// 업로드 후 저장된 파일명
	
	// 파일 크기 산출
	File file = multiReq.getFile("fileName");
	fileSize = (int)file.length();
	
} catch (IOException e ) {
	out.print(e.getMessage());
}
%>    
    
    
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" href="/style/style.css?v">
</head>
<body>
	<div id="wrap">
		<h1>업로드 페이지</h1>
		
		<main id="main">
			<p>제목 : <%=subject %></p>
			<p>내용 : <%=content %></p>
			<p>원본파일명 : <%=originalFile %></p>
			<p>업로드파일명 : <%=uploadFile %></p>
			<p>파일크기 : <%=fileSize %></p>
		</main>
		
		<button type="button" onclick="history.back()">돌아가기</button>
	</div>
	<!-- div#wrap -->
	<script src="/script/jquery-3.7.1.min.js"></script>
	<script src="/script/script.js"></script>
</body>
</html>    