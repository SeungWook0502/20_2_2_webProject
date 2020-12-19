<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="club.clubDAO" %>
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

	String clubName=null;
	if(session.getAttribute("clubName")==null){
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'ClubMain.jsp'");
		script.println("</script>");
	}
	else{
		clubName=(String)session.getAttribute("clubName");

	String userID =null;
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	clubDAO ClubDAO = new clubDAO();
	String check=ClubDAO.clubCmp(userID,clubName);
	if(check == "NON"){ //로그인되지 않은 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	else{
		
		String fileRealName=null;
		if(request.getParameter("fileRealName")!=null){
			fileRealName=request.getParameter("fileRealName");
		}
		FileDAO fileDAO = new FileDAO();
		PrintWriter script = response.getWriter();
		if(fileDAO.delete(fileRealName)!=-1){
		
		script.println("<script>");
		script.println("alert('"+fileRealName+" 파일이 삭제 되었습니다.')");
		script.println("location.href='file.jsp'");
		script.println("</script>");
		}
		else{
			script.println("<script>");
			script.println("alert('유효하지 않은 게시물입니다.')");
			script.println("location.href='file.jsp'");
			script.println("</script>");
		}
	}
	}
	%>
	
</body>
</html>