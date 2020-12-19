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
<%--<jsp:setProperty name="file" property="bbsContent" />--%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		clubDAO ClubDAO = new clubDAO();
		String removeClubName=null;
		if(request.getParameter("ClubName")!=null){
			removeClubName=request.getParameter("ClubName");
		}
		PrintWriter script = response.getWriter();
		if(ClubDAO.removeClub(removeClubName)!=-1){
		
		script.println("<script>");
		script.println("alert('"+removeClubName+" 동아리가 삭제 되었습니다.')");
		script.println("location.href='ClubMain.jsp'");
		script.println("</script>");
		}
		else{
			script.println("<script>");
			script.println("alert('유효하지 않은 동아리입니다.')");
			script.println("location.href='ClubMain.jsp'");
			script.println("</script>");
		}
	%>
	
</body>
</html>