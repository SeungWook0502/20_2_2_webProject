<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="club.clubDAO" %>
<%@ page import="FILE.FileDAO" %>
<%@ page import="FILE.FileDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="BBS.BbsDAO" %>
<%@ page import="BBS.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css"> <%-- 사용할 css파일 link --%>
<link rel="stylesheet" href="css/custom.css">
<title>JSP 파일 업로드</title>
<style type="text/css">
	a,a:hover{
		color:#000000;
		text-decoration: none;
	}
</style>
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
	int pageNumber = 1;
	if(request.getParameter("pageNumber")!=null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				<li class="active"><a href="file.jsp">갤러리</a></li>
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
			<table class="table table-striped"<%-- 홀짝 줄무늬 --%> style="text-align:center; border:1px solid #dddddd ">
				<thead> <%--table의 제목부분 --%>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align:center;"><%=clubName %> 갤러리</th>
					</tr>
				</thead>
				<tbody>
				<%
				String directory = application.getRealPath("/fileUpload/");
				FileDAO fileDAO = new FileDAO();
				ArrayList<FileDTO> fileList = fileDAO.Gallery(clubName);
				
				
				for(int i = 0;i<fileList.size();i++){
					%>
					<tr>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td style="width: 20%;">제목</td>
						<td colspan="2"><%= fileList.get(i).getFileComment() %></td>
					<tr>
						<td>게시일자</td>
						<td colspan="2"><%= fileList.get(i).getFileDate().substring(0,11)+fileList.get(i).getFileDate().substring(11,13)+"시"+fileList.get(i).getFileDate().substring(14,16)+"분" %></td>
					</tr>
					<tr>
						<td colspan="2"><img src="fileUpload/<%=fileList.get(i).getFileRealName() %>" width="500" height="400" border="3"></td>
					</tr>
					<tr colspan="3">
						<td colspan="2"></td>
					</tr>
					
					<%
					}
				
				}
				%>
				</tbody>
			</table>
		</div>
	</div>

			<%
			clubDAO ClubDAO = new clubDAO();
			String userID=(String)session.getAttribute("userID");
			String check=ClubDAO.clubCmp(userID,clubName);
			if(check != "NON"){ //로그인되지 않은 경우
			%>
			<div class="container">
				
				<a href="fileUpload.jsp" type="submit" class="btn btn-primary pull-right">파일올리기</a>
			</div>
			<%
			}
			%>
			
			
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>