<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
				<li><a href="main.jsp"><%=clubName %></a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="file.jsp">파일</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li class="active"><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4"></div>
		<div class="jumbotron" style="padding-top:20px;">
			<form method="post" action="joinAction.jsp"> <%-- 로그인 결과 data를 다룬다. --%>
				<h3 style="text-align: center;">회원가입</h3>
				<div class="form-group">
					<input type="text" class="form-control" name="clubName" maxlength="20" readonly value=<%= clubName %>>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
				</div>
				<div class="form-group">
					<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
				</div>
				<div class="form-group" style="text-align: center;">
					<div class="btn btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <%-- active는 default값 설정 --%>
							<input type="radio" name="userGender" autocomplete="off" value="0" checked>남자
						</label>
						<label class="btn btn-primary">
							<input type="radio" name="userGender" autocomplete="off" value="1" checked>여자
						</label>
					</div>
				</div>
				<div class="form-group">
					<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
				</div>
				<div class="form-group">
					<input type="tel" class="form-control" placeholder="전화번호" name="userPhone"placeholder="00*-000*-0000" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlenght="20">
				</div>
				<div class="form-group" style="text-align: center;">
					<div class="btn btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <%-- active는 default값 설정 --%>
							<input type="radio" name="userAdmin" autocomplete="off" value="사용자" checked>사용자
						</label>
						<label class="btn btn-primary">
							<input type="radio" name="userAdmin" autocomplete="off" value="관리자" checked>관리자
						</label>
					</div>
				</div>
				<input type="submit" class="btn btn-primary form-control" value="회원가입">
			</form>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<%
	}
	%>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>