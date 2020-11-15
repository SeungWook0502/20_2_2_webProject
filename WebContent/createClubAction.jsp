<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="club.clubDAO" %>
   <%@ page import="user.UserDAO" %>
   <%@ page import="java.io.PrintWriter" %>
   <% request.setCharacterEncoding("UTF-8"); %> <%-- 넘어오는 모든 DATA를 UTF-8로 바꾼다 --%>
<jsp:useBean id="club" class="club.club" scope="page" /> <%-- UserBean클래스의 이용 --%>
<jsp:setProperty name="club" property="clubName" />
   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	
	<%
		clubDAO ClubDAO = new clubDAO();
	
		if(club.getClubName()==null){
			//값을 1개라도 넣지 않은 경우를 확인
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ //값을 모두 넣은경우
			String clubName = (String)club.getClubName();
			int result = ClubDAO.mkClub(clubName);
			if(result==-1){	//insert하기 때문에 DB에 이미 존재할 경우 -1을 반환한다.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 동아리입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else { //성공적으로 입력됨
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'ClubMain.jsp'");
				script.println("</script>");
			}
		}
	%>
	
</body>
</html>