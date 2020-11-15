<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="user.UserDAO" %>
   <%@ page import="BBS.BbsDAO" %>
   <%@ page import="BBS.Bbs" %>
   <%@ page import="java.io.PrintWriter" %>
   <% request.setCharacterEncoding("UTF-8"); %> <%-- 넘어오는 모든 DATA를 UTF-8로 바꾼다 --%>
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

		int bbsID = 0;
		if(request.getParameter("bbsID")!=null){
			bbsID=Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs=new BbsDAO().getBbs(bbsID);
		UserDAO userDAO = new UserDAO();
		int userAdmin=Integer.parseInt(userDAO.searchAdmin(userID));
		if(!userID.equals(bbs.getUserID()) && userAdmin != 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} 
		else{
		
			BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.delete(bbsID); //추가할 수 있도록 메소드로 값을 보낸다.
				
				if(result==-1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else { //성공적으로 입력됨
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글이 삭제되었습니다.')");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
		}		
	%>
	
</body>
</html>