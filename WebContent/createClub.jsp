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
				<li class="active"><a href="ClubMain.jsp">메인</a></li> <%-- active접속페이지임을 보인다. --%>
			</ul>
			
		</div>
	</nav>
	<div class="container">
	<%
		clubDAO ClubDAO = new clubDAO();
		ArrayList<club> list = ClubDAO.getClubList();
	%>
		<form method="post" action="createClubAction.jsp"><thead> <%--table의 제목부분 --%>
			<table class="table table-striped"<%-- 홀짝 줄무늬 --%> style="text-align:center; border:1px solid #dddddd ">
			<thead>
			<tr>
				<th colspan="2"<%-- 2개만큼의 열을 이용 --%> style="background-color: #eeeeee; text-align:center;">동아리 생성하기</th>
			</tr>
			</thead>
			<tbody>
			<div>
				<td><input type="text" class="form-control" placeholder="동아리 이름" name="clubName" maxlength="20"></td>
			</div>
			<div>
				<td><input type="submit" class="btn btn-primary pull-right" value="동아리 생성"></td>
			</div>
			</tbody>
			</table>
		</form>
	</div>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>