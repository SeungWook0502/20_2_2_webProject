<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
	session.invalidate(); //session값을 뺏는다.
%>

<%
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그아웃 되었습니다.')");
	script.println("location.href='main.jsp'");
	script.println("</script>");
%>
<%--
<script>
	location.href='main.jsp';
</script>
--%>
</body>
</html>