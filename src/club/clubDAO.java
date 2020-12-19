package club;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import club.club;

public class clubDAO {
	
	private Connection conn;

	private ResultSet rs;
	
	public clubDAO() { //실제로 DB에 접속해서 DATA를 가져오거나 DATA를 넣는 DATA접근 객체
		
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
	
	public int mkClub(String clubName) {
		String SQL = "insert into club values(?)"; //내림차순중 가장낮은것
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, clubName);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	}
	
	public ArrayList<club> getClubList(){
		String SQL = "SELECT * FROM club";
		ArrayList<club> clubList = new ArrayList<club>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			rs=pstmt.executeQuery();
			while (rs.next()) {
				club Club  = new club();
				Club.setClubName(rs.getString(1));
				clubList.add(Club);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return clubList;
	}

	public String clubCmp(String userID,String clubName){
		String SQL = "select userID from user where userID=? and clubName=?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, clubName);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "NON";
	}
	
	public int removeClub(String clubName) {
		String SQL = "delete from club where clubName = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, clubName);
			return pstmt.executeUpdate(); //0이상의 값이 반환되기 때문에 성공적으로 리턴한다.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//DB오류
		
	}
}
