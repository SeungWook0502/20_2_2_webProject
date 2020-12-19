<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="club.clubDAO" %>
   <%@ page import="REPLY.Reply" %>
   <%@ page import="REPLY.ReplyDAO" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.PrintWriter" %>
   <% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="reply" class="REPLY.Reply" scope="page" />
<jsp:setProperty name="reply" property="replyID" />
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		if(session.getAttribute("bbsID")==null){
		
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		ReplyDAO replyDAO = new ReplyDAO();
		int bbsID = 0;
		if(session.getAttribute("bbsID")!=null){
			bbsID=(int)session.getAttribute("bbsID");
		}
		System.out.println(bbsID);
		System.out.println(reply.getReplyID());
		PrintWriter script = response.getWriter();
		if(replyDAO.deleteReply(bbsID,reply.getReplyID())!=-1){
			script.println("<script>");
			script.println("alert('댓글이 삭제 되었습니다.')");
			script.println("location.href='view.jsp?bbsID="+bbsID+"'");
			script.println("</script>");
		}else{
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
	%>
	
</body>
</html>