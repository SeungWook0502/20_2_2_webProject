<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="FILE.FileDAO" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.PrintWriter" %>
   <%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
   <%@ page import="com.oreilly.servlet.MultipartRequest" %>
   <% request.setCharacterEncoding("UTF-8"); %> <%-- 넘어오는 모든 DATA를 UTF-8로 바꾼다 --%>
<jsp:useBean id="file" class="FILE.FileDTO" scope="page" /> <%-- UserBean클래스의 이용 --%>
<jsp:setProperty name="file" property="fileComment" />
<%--<jsp:setProperty name="file" property="bbsContent" />--%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
				

	String userID =null;
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null){	//로그인되어있어야 작성이 가능하다.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	else{
		//값을 모두 넣은경우
			String directory = application.getRealPath("/fileUpload/");
			int maxSize=1024*1024*100;
			String encoding = "UTF-8";
		
			MultipartRequest multipartRequest = new MultipartRequest(request,directory,maxSize,encoding,new DefaultFileRenamePolicy());
		
			String fileName = multipartRequest.getOriginalFileName("file");
			String fileRealName = multipartRequest.getFilesystemName("file");
			String fileComment = multipartRequest.getParameter("fileComment");
			System.out.println(fileComment);
			new FileDAO().upload(fileName,fileRealName,fileComment);
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('"+fileName+" 파일이 업로드 되었습니다.')");
			script.println("location.href='file.jsp'");
			script.println("</script>");
		
	}
	%>
	
</body>
</html>