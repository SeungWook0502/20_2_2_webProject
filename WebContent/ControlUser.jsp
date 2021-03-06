<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="club.clubDAO" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css"> <%-- 사용할 css파일 link --%>
<link rel="stylesheet" href="css/custom.css">
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
				<li><a href="main.jsp"><%=clubName %></a></li> <%-- active접속페이지임을 보인다. --%>
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="file.jsp">갤러리</a></li>
				<li class="active"><a href="ControlUser.jsp">관리</a></li>
			</ul>
			<%
			clubDAO ClubDAO = new clubDAO();
			String check=ClubDAO.clubCmp(userID,clubName);
			if(check == "NON"){ //로그인되지 않은 경우
				System.out.println("non");
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				}else {				//로그인 되어있는 경우
					UserDAO userDAO = new UserDAO();
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#" >사용자ID : <%= userID %></a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="myPage.jsp">내 정보</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
			
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
			<% 
			UserDAO userDAO = new UserDAO();
			%>
			<div>
				동아리원 수 : <%= userDAO.userCount(clubName) %>
			</div>
			<table class="table table-striped"<%-- 홀짝 줄무늬 --%> style="text-align:center; border:1px solid #dddddd ">
				<thead> <%--table의 제목부분 --%>
					<tr>
						<th style="background-color: #eeeeee; text-align:center;">ID</th>
						<th style="background-color: #eeeeee; text-align:center;">Password</th>
						<th style="background-color: #eeeeee; text-align:center;">Name</th>
						<th style="background-color: #eeeeee; text-align:center;">Gender</th>
						<th style="background-color: #eeeeee; text-align:center;">Email</th>
						<th style="background-color: #eeeeee; text-align:center;">Phone</th>
						<th style="background-color: #eeeeee; text-align:center;"></th>
						
					</tr>
				</thead>
				<tbody>
					<%
						ArrayList<User> list = userDAO.getControlPage(clubName);
						for(int i = 0;i<list.size();i++){
					%>
					<tr>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getUserPassword() %></td>
						<td><%= list.get(i).getUserName() %></td>
						<td><%= list.get(i).getUserGender() %></td>
						<td><%= list.get(i).getUserEmail() %></td>
						<td><%= list.get(i).getUserPhone() %></td>
						<%
							if(userID.equals(list.get(i).getUserID())){
						%>
						<td><a href="myPage.jsp">내 정보 변경하기</a></td>
						<%
							}else {
						%>
						<td><a href="remoteWithDrawAction.jsp?ControlUserID=<%= list.get(i).getUserID() %>">탈퇴시키기</a></td>
						<%
							}
						%>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	
	<%		
		}
	%>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>