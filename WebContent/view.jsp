<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="club.clubDAO" %>
<%@ page import="BBS.Bbs" %>
<%@ page import="BBS.BbsDAO" %>
<%@ page import="REPLY.Reply" %>
<%@ page import="REPLY.ReplyDAO" %>
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
	int bbsID = 0;
	if(request.getParameter("bbsID")!=null){
		bbsID=Integer.parseInt(request.getParameter("bbsID"));
	}
	session.setAttribute("bbsID",bbsID);
	if(bbsID==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
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
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<li><a href="file.jsp">갤러리</a></li>
				<%
				clubDAO ClubDAO = new clubDAO();
				String check=ClubDAO.clubCmp(userID,clubName);
				UserDAO userDAO = new UserDAO();
				int userAdmin=Integer.parseInt(userDAO.searchAdmin(userID));
				if(userID != null && userAdmin == 1&&check!="NON"){
				%>
				<li><a href="ControlUser.jsp">관리</a></li>
				<%	
				}
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
						<th colspan="4"<%-- 2개만큼의 열을 이용 --%> style="background-color: #eeeeee; text-align:center;"><%=clubName %> 게시판 글보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="1" style="width: 20%;">글제목</td>
						<td colspan="3"><%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\n","<br>") %></td>
					</tr>
					<tr>
						<td colspan="1" >작성자</td>
						<td colspan="3"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td colspan="1" >작성일자</td>
						<td colspan="3"><%= bbs.getBbsDate().substring(0,11)+bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분" %></td>
					</tr>
					<tr>
						<td colspan="1" >내용</td>
						<td colspan="3" style="min-height:200px; text-align:left"><%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\n","<br>") %></td> <%--특수문자 처리 --%>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td colspan="1"><a href="bbs.jsp" class="btn btn-primary">목록</a></td>
						<%
						userAdmin=Integer.parseInt(userDAO.searchAdmin(userID));
							if(userID != null || userAdmin == 1){	
									if(userID.equals(bbs.getUserID())){
						%>
							
								<td colspan="1"><a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a></td>
							<%		
								}
							%>
							<td colspan="1"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href = deleteAction.jsp?bbsID=<%= bbsID %> class="btn btn-primary">삭제</a></td>
						<%		
							}
						%>
						<td colspan="1"><a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a></td>
					</tr>
				</tbody>			
			</table>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<table class="table table-striped"<%-- 홀짝 줄무늬 --%> style="text-align:center; border:1px solid #dddddd ">
				<thead> <%--table의 제목부분 --%>
					<tr>
						<th colspan="5"<%-- 2개만큼의 열을 이용 --%> style="background-color: #eeeeee; text-align:center;">댓글 작성</th>
					</tr>
				</thead>
				<tbody>
					<form method="post" action="replyAction.jsp?bbsID=<%= bbsID %>">
						<tr>
							<td colspan="1" style="width: 20%;">작성</td>
							<td colspan="3"><input type="text" class="form-control" placeholder="댓글내용" name="comment"></td>
							<td colspan="1"><input type="submit" class="btn btn-primary form-right" value="댓글작성"></td>
						</tr>
					</form>
				</tbody>
			</table>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table class="table table-striped"<%-- 홀짝 줄무늬 --%> style="text-align:center; border:1px solid #dddddd ">
				<thead> <%--table의 제목부분 --%>
					<tr>
						<th colspan="1" style="background-color: #eeeeee; text-align:center;">작성자</th>
						<th colspan="2" style="background-color: #eeeeee; text-align:center;">내용</th>
						<th colspan="1" style="background-color: #eeeeee; text-align:center;">작성 일자</th>
						<th colspan="1" style="background-color: #eeeeee; text-align:center;"></th>
					</tr>
				</thead>
				<tbody>

					<%
						ReplyDAO replyDAO = new ReplyDAO();
						ArrayList<Reply> list = replyDAO.getList(bbsID);
						for(int i = 0;i<list.size();i++){
							if(bbs.getUserID().equals(userID)){ //글 작성자인 경우
					%>
						<tr>
							<td colspan="1"><%= list.get(i).getUserID() %></td>
							<td colspan="2"><%= list.get(i).getComment() %></td>
							<td colspan="1"><%= list.get(i).getReplyDate().substring(0,11)+list.get(i).getReplyDate().substring(11,13)+"시"+list.get(i).getReplyDate().substring(14,16)+"분" %></td>
							<td colspan="1"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href = deleteReplyAction.jsp?replyID=<%= list.get(i).getReplyID() %> class="btn btn-primary">댓글 삭제</a></td>
						</tr>
					<%
							}else if(list.get(i).getUserID().equals(userID)){ //댓글 작성자인 경우
					%>
						<tr>
							<td colspan="1"><%= list.get(i).getUserID() %></td>
							<td colspan="2"><%= list.get(i).getComment() %></td>
							<td colspan="1"><%= list.get(i).getReplyDate().substring(0,11)+list.get(i).getReplyDate().substring(11,13)+"시"+list.get(i).getReplyDate().substring(14,16)+"분" %></td>
							<td colspan="1"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href = deleteReplyAction.jsp?replyID=<%= list.get(i).getReplyID() %> class="btn btn-primary">댓글 삭제</a></td>
						</tr>		
					<%
							}else{
					%>
						<tr>
							<td colspan="1"><%= list.get(i).getUserID() %></td>
							<td colspan="2"><%= list.get(i).getComment() %></td>
							<td colspan="1"><%= list.get(i).getReplyDate().substring(0,11)+list.get(i).getReplyDate().substring(11,13)+"시"+list.get(i).getReplyDate().substring(14,16)+"분" %></td>
							<td colspan="1"></td>
						</tr>
					<%
							}}
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