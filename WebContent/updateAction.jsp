<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="BBS.BbsDAO" %>
   <%@ page import="BBS.Bbs" %>
   <%@ page import="java.io.PrintWriter" %>
   <% request.setCharacterEncoding("UTF-8"); %> <%-- 넘어오는 모든 DATA를 UTF-8로 바꾼다 --%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	
	<%
		String userID =null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){	//로그인되어있어야 작성이 가능하다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}

		int bbsID = 0;
		if(request.getParameter("bbsID")!=null){
			bbsID=Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs=new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} 
		else{
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle").equals("") ||request.getParameter("bbsContent").equals("")){ //정보입력이 없다면 다시
				//값을 1개라도 넣지 않은 경우를 확인
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{ //값을 모두 넣은경우
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID,request.getParameter("bbsTitle"),request.getParameter("bbsContent")); //추가할 수 있도록 메소드로 값을 보낸다.
				
				if(result==-1){	//insert하기 때문에 DB에 이미 존재할 경우 -1을 반환한다.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else { //성공적으로 입력됨
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
			}
		}		
	%>
	
</body>
</html>