<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="club.clubDAO" %>
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
<jsp:setProperty name="user" property="clubName" />
   
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
		clubDAO ClubDAO = new clubDAO();
		String check=ClubDAO.clubCmp(userID,clubName);
		if(check != "NON"){ //로그인되지 않은 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		if(user.getUserID()==null || user.getUserPassword()==null || user.getUserName()==null || user.getUserGender()==null || user.getUserEmail()==null ||user.getUserPhone()==null||user.getUserAdmin()==null){
			//값을 1개라도 넣지 않은 경우를 확인
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ //값을 모두 넣은경우
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user,clubName); //추가할 수 있도록 메소드로 값을 보낸다.
			
			if(result==-1){	//insert하기 때문에 DB에 이미 존재할 경우 -1을 반환한다.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else { //성공적으로 입력됨
				session.setAttribute("userID",user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
	
</body>
</html>