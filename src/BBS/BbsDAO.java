package BBS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;

	private ResultSet rs;
	
	public BbsDAO() { //실제로 DB에 접속해서 DATA를 가져오거나 DATA를 넣는 DATA접근 객체
		
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public String getDate() {
		String SQL = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO에 받는 데이터가 많기때문에
			//데이터마다 분류해주기 위해 pstmt를 method마다 따로 둔다
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //DB오류
	}

	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; //내림차순중 가장낮은것
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO에 받는 데이터가 많기때문에
			//데이터마다 분류해주기 위해 pstmt를 method마다 따로 둔다
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫번째 게시물인 경우
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	}
	public int write(String bbsTitle, String userID, String bbsContent,String clubName) {
		String SQL = "insert into bbs values(?,?,?,?,?,?,?)"; //내림차순중 가장낮은것
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); //최초작성인 경우 Avaliable이 참이여야(보여주기)한다
			pstmt.setString(7, clubName);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	}
	
	public ArrayList<Bbs> getList(int pageNumber,String clubName){
		String SQL = "SELECT bbsID,bbsTitle,userID,bbsDate,bbsContent,bbsAvailable FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 AND clubName = ? order by bbsID DESC LIMIT 10"; //내림차순중 가장낮은것
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO에 받는 데이터가 많기때문에
			//데이터마다 분류해주기 위해 pstmt를 method마다 따로 둔다
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			pstmt.setString(2, clubName);
			rs=pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //DB오류
	}
	
	public boolean nextPage(int pageNumber,String clubName) {	//Pagging처리를 위한 함수
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 AND clubName = ?"; //내림차순중 가장낮은것
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO에 받는 데이터가 많기때문에
			//데이터마다 분류해주기 위해 pstmt를 method마다 따로 둔다
			pstmt.setInt(1, getNext()-(pageNumber - 1)*10);
			pstmt.setString(2, clubName);
			rs=pstmt.executeQuery();
			if(rs.next()) {	//다음페이지로 넘어갈 수 있음
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false; //DB오류
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()) {	//다음페이지로 넘어갈 수 있음
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null; //DB오류
	}

	public int update(int bbsID,String bbsTitle,String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle=?,bbsContent =? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	}


	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	
	}
}



