<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="club.club" %>
<%@ page import="club.clubDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<%-- 사용할 css파일 link --%>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">

<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	%>
	<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="ClubMain.jsp">학교 동아리 통합 사이트</a>
		</div>
	</nav>
	<div class="container">
	<%
		clubDAO ClubDAO = new clubDAO();
		ArrayList<club> list = ClubDAO.getClubList();
		for(int i = 0;i<list.size();i++){
	%>
			<form method="post" action="visitAction.jsp">
				<div>
					<input type="submit" class="btn btn-primary form-control" value="<%=list.get(i).getClubName()%>" name="clubName">
				</div>
	<%
		}
	%>
			</form>
			<form method="post" action="createClub.jsp">
			<p></p>
				<input type="submit" class="btn btn-primary pull-right" value="동아리 생성">
			</form>
	
	</div>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>