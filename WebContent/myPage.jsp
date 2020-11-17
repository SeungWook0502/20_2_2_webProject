<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="club.clubDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
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
			<a class="navbar-brand" href="main.jsp">학교 동아리 통합 페이지</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp"><%=clubName %></a></li> <%-- active접속페이지임을 보인다. --%>
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="file.jsp">갤러리</a></li>
				<%
				UserDAO userDAO = new UserDAO();
				int userAdmin=Integer.parseInt(userDAO.searchAdmin(userID));
				if(userID != null && userAdmin == 1){
				%>
				<li><a href="ControlUser.jsp">관리</a></li>
				<%	
				}
				%>
			</ul>
			<%
				clubDAO ClubDAO = new clubDAO();
				String check=ClubDAO.clubCmp(userID,clubName);
				if(check == "NON"){ //로그인되지 않은 경우
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
			%>			
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#" >사용자ID : <%= userID %></a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="myPage.jsp">내 정보</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
			<%
			ArrayList<User> list = userDAO.getUserPage(userID);
			User user= list.get(0);
			%>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4"></div>
		<div class="jumbotron" style="padding-top:20px;">
			<form method="post" action="myPageAction.jsp"> <%-- 로그인 결과 data를 다룬다. --%>
				<h3 style="text-align: center;">내 정보</h3>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20" readonly value="<%= user.getUserID() %>">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20" value="<%=user.getUserPassword() %>">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" value="<%=user.getUserName() %>">
				</div>
				<div class="form-group" style="text-align: center;">
					<div class="btn btn-group" data-toggle="buttons">
				<%
				if(user.getUserGender().equals("남자")){ 
				%>
						<label class="btn btn-primary active"> <%-- active는 default값 설정 --%>
							<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
						</label>
						<label class="btn btn-primary">
							<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
						</label>
				<%
					}else{ 
				%>
						<label class="btn btn-primary"> <%-- active는 default값 설정 --%>
							<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
						</label>
						<label class="btn btn-primary active">
							<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
						</label>
						
				<%
					}
				%>
					</div>
				</div>
				<div class="form-group">
					<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20" value="<%=user.getUserEmail() %>">
				</div>
				<div class="form-group">
					<input type="tel" class="form-control" placeholder="전화번호" name="userPhone"placeholder="00*-000*-0000" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlenght="20" value="<%=user.getUserPhone() %>">
				</div>
				<div class="form-group" style="text-align: center;">
					<div class="btn btn-group" data-toggle="buttons">
				<%
					if(user.getUserAdmin().equals("0")){ 
				%>
						<label class="btn btn-primary active"> <%-- active는 default값 설정 --%>
							<input type="radio" name="userAdmin" autocomplete="off" value="0" checked>사용자
						</label>
						<label class="btn btn-primary">
							<input type="radio" name="userAdmin" autocomplete="off" value="1" checked>관리자
						</label>
				<%
					}else{ 
				%>
						<label class="btn btn-primary"> <%-- active는 default값 설정 --%>
							<input type="radio" name="userAdmin" autocomplete="off" value="0" checked>사용자
						</label>
						<label class="btn btn-primary active">
							<input type="radio" name="userAdmin" autocomplete="off" value="1" checked>관리자
						</label>
				<%
					}
				%>
					</div>
				</div>
				<div>
						<input type="submit" class="btn btn-primary form-control" value="변경">
						<a href="main.jsp" type="submit" class="btn btn-primary form-control" value="취소">취소</a>
				</div>
			</form>
			<from method="post" action="withDrawAction.jsp">
				<a onclick="return confirm('정말로 탈퇴하시겠습니까?')" href="withDrawAction.jsp" type="submit" class="btn btn-primary form-control" value="탈퇴">회원탈퇴</a>
			</from>
		</div>
		<div class="col-lg-4"></div>
			<%
				}
			%>
		
	</div>
	
			<%
				}
			%>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>