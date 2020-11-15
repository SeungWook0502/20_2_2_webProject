<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="user.UserDAO" %>
   <%@ page import="java.io.PrintWriter" %>
   <% request.setCharacterEncoding("UTF-8"); %> <%-- 넘어오는 모든 DATA를 UTF-8로 바꾼다 --%>
<jsp:useBean id="user" class="user.User" scope="page" /> <%-- UserBean클래스의 이용 --%>
<jsp:setProperty name="user" property="userID" />	<%--  --%>
  
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
			System.out.println("Club확인 : "+clubName);
			
		String userID =null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('미가입된 동아리 입니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		String result = userDAO.searchPassword(user.getUserID(),clubName);
		
		if(result.equals("-1")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result.equals("-2")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			PrintWriter script = response.getWriter();
			
			StringBuilder pssword = new StringBuilder(result.substring(0,3));
			StringBuilder starword= new StringBuilder();
			for(int i=0;i<result.length()-3;i++)starword.append("*");
			String pssword2=pssword.toString();
			String starword2=starword.toString();
			
			script.println("<script>");
			script.println("alert('"+ pssword2 + starword2 +"')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
			//script.println("</script>");
		}
	}
	%>
	
</body>
</html>