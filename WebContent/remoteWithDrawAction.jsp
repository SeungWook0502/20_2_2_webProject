<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="user.UserDAO" %>
   <%@ page import="java.io.PrintWriter" %>
   <% request.setCharacterEncoding("UTF-8"); %> <%-- 넘어오는 모든 DATA를 UTF-8로 바꾼다 --%>
<jsp:useBean id="user" class="user.User" scope="page" /> <%-- UserBean클래스의 이용 --%>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userPhone" />
<jsp:setProperty name="user" property="userAdmin" />
   
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
		
		String ControlUserID = null;
		if(request.getParameter("ControlUserID")!=null){
			ControlUserID=request.getParameter("ControlUserID");
			System.out.println(ControlUserID);
		}
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.withDraw(ControlUserID,clubName); //추가할 수 있도록 메소드로 값을 보낸다.
		userID = (String)session.getAttribute("userID");
			
		if(result==-1){	//insert하기 때문에 DB에 이미 존재할 경우 -1을 반환한다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('없는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
			
		}
		else { //성공적으로 입력됨
			session.setAttribute("userID",userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원탈퇴 되었습니다.')");
			script.println("location.href = 'ControlUser.jsp'");
			script.println("</script>");
		
		}
	}
		
	%>
	
</body>
</html>