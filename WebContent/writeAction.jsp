<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="club.clubDAO" %>
   <%@ page import="BBS.BbsDAO" %>
   <%@ page import="java.io.PrintWriter" %>
   <% request.setCharacterEncoding("UTF-8"); %> <%-- 넘어오는 모든 DATA를 UTF-8로 바꾼다 --%>
<jsp:useBean id="bbs" class="BBS.Bbs" scope="page" /> <%-- UserBean클래스의 이용  id는 class명으로 이용된다--%>
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
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
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){ //정보입력이 없다면 다시
				//값을 1개라도 넣지 않은 경우를 확인
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{ //값을 모두 넣은경우
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(),userID,bbs.getBbsContent(),clubName); //추가할 수 있도록 메소드로 값을 보낸다.
				
				if(result==-1){	//insert하기 때문에 DB에 이미 존재할 경우 -1을 반환한다.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else { //성공적으로 입력됨
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
			}
		}		
		}
	%>
	
</body>
</html>