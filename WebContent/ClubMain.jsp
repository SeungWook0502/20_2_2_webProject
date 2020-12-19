<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="club.club" %>
<%@ page import="club.clubDAO" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
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
		session.setAttribute("clubName","ClubMain");
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
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<%
				clubDAO ClubDAO = new clubDAO();
				String check=ClubDAO.clubCmp(userID,"ClubMain");
				UserDAO userDAO = new UserDAO();
				int userAdmin=Integer.parseInt(userDAO.searchAdmin(userID));
				%>
			</ul>
			<%
			if(check == "NON"){ //로그인되지 않은 경우
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
					</ul>
				</li>
			</ul>
			<%
				}else {				//로그인 되어있는 경우
			%>			
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#" >사용자ID : <%= userID %></a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
			
		</div>
	</nav>
	
	<%if(userAdmin==2){ %>
		<div class="container">
			<table class="table table-striped"<%-- 홀짝 줄무늬 --%> style="text-align:center; border:1px solid #dddddd ">
			<thead>
				<tr>
					<th colspan="5" style="background-color: #eeeeee; text-align:center;"></th>
				</tr>
			</thead>
		<%
			ArrayList<club> list = ClubDAO.getClubList();
			for(int i = 0;i<list.size();i++){
		%>
				<form method="post" action="visitAction.jsp">
					<tr colspan = "5">
						<td colspan="4"><input type="submit" class="btn btn-primary form-control" value="<%=list.get(i).getClubName()%>" name="clubName"></td>
						<td colspan="1"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href = deleteClubAction.jsp?ClubName=<%= list.get(i).getClubName() %> class="btn btn-primary">동아리 삭제</a></td>
					</tr>
		<%
			}
		%>
				</form>
			</table>
				
		</div>
		<form method="post" action="createClub.jsp">
			<p></p>
			<input type="submit" class="btn btn-primary pull-right" value="동아리 생성">		
		</form>
	<%}else{ %>
		<div class="container">
			<table class="table table-striped"<%-- 홀짝 줄무늬 --%> style="text-align:center; border:1px solid #dddddd ">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align:center;"></th>
				</tr>
			</thead>
		<%
			ArrayList<club> list = ClubDAO.getClubList();
			for(int i = 0;i<list.size();i++){
		%>
				<form method="post" action="visitAction.jsp">
					<tr>
						<td><input type="submit" class="btn btn-primary form-control" value="<%=list.get(i).getClubName()%>" name="clubName"></td>
					</tr>
			<%} %>
				</form>
			</table>
	<%}%>
			
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>