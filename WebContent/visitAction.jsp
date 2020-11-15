<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.io.PrintWriter" %>
   <% request.setCharacterEncoding("UTF-8"); %> <%-- 넘어오는 모든 DATA를 UTF-8로 바꾼다 --%>
<jsp:useBean id="Club" class="club.club" scope="page" />
<jsp:setProperty name="Club" property="clubName" />
   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	
	<%
		String clubName = Club.getClubName();
		//session.setAttribute("clubName",club.getClubName());
		if(session.getAttribute("clubName") != null) { //session이 있는경우
			clubName = (String)session.getAttribute("clubName");
		}
		if(clubName == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='ClubMain.jsp'");
			script.println("</script>");
		}
		else{
			
			session.setAttribute("clubName",Club.getClubName());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
	%>
	
</body>
</html>