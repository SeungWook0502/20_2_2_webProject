package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import BBS.Bbs;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() { //실제로 DB에 접속해서 DATA를 가져오거나 DATA를 넣는 DATA접근 객체
		
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
	
	public int login(String userID,String userPassword,String clubName) { //해킹을 막기위해 DB에서 Direct로 가져오는 방식
		String SQL = "select userPassword from USER WHERE userID = ? and clubName=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userID);
			pstmt.setNString(2, clubName);
			rs=pstmt.executeQuery(); //결과를 담을 수 있는 하나으 객체
			if(rs.next()) {			//ID가 있는경우
				if(rs.getNString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				else return 0;//비밀번호 불일치
			}
			return -1; //아이디가 없음
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public String searchPassword(String userID,String clubName) { //해킹을 막기위해 DB에서 Direct로 가져오는 방식
		String SQL = "select userPassword from USER WHERE userID = ? and clubName = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userID);
			pstmt.setNString(2, clubName);
			rs=pstmt.executeQuery(); //결과를 담을 수 있는 하나으 객체
			if(rs.next()) {			//ID가 있는경우
				return rs.getNString(1); //로그인 성공
			}
			return "-1"; //아이디가 없음
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "-2";
	}
	
	public String searchAdmin(String userID) { //해킹을 막기위해 DB에서 Direct로 가져오는 방식
		String SQL = "select userAdmin from USER WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userID);
			rs=pstmt.executeQuery(); //결과를 담을 수 있는 하나으 객체
			if(rs.next()) {			//ID가 있는경우
				return rs.getNString(1); //로그인 성공
			}
			return "-1"; //아이디가 없음
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "-2";
	}
	
	public int join(User user,String clubName) {
		String SQL = "insert into USER values(?,?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, user.getUserID());
			pstmt.setNString(2, user.getUserPassword());
			pstmt.setNString(3, user.getUserName());
			pstmt.setNString(4, user.getUserGender());
			pstmt.setNString(5, user.getUserEmail());
			pstmt.setNString(6, user.getUserPhone());
			pstmt.setNString(7, user.getUserAdmin());
			pstmt.setNString(8, clubName);
			return pstmt.executeUpdate(); //0이상의 값이 반환되기 때문에 성공적으로 리턴한다.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//DB오류
		
	}
	public ArrayList<User> getUserPage(String userID){
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO에 받는 데이터가 많기때문에
			//데이터마다 분류해주기 위해 pstmt를 method마다 따로 둔다
			pstmt.setNString(1, userID);
			rs=pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserPhone(rs.getString(6));
				user.setUserAdmin(rs.getString(7));
				list.add(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //DB오류
	}
	public ArrayList<User> getControlPage(String clubName){
		String SQL = "SELECT * FROM USER WHERE clubName = ?";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, clubName);
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserPhone(rs.getString(6));
				user.setUserAdmin(rs.getString(7));
				list.add(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //DB오류
	}
	
	public int reJoin(User user) {
		String SQL = "update USER set userPassword=?, userName=?, userGender=?, userEmail=?, userPhone=?, userAdmin=? where userID = ?";
		try {

			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, user.getUserPassword());
			pstmt.setNString(2, user.getUserName());
			pstmt.setNString(3, user.getUserGender());
			pstmt.setNString(4, user.getUserEmail());
			pstmt.setNString(5, user.getUserPhone());
			pstmt.setNString(6, user.getUserAdmin());
			pstmt.setNString(7, user.getUserID());
			return pstmt.executeUpdate(); //0이상의 값이 반환되기 때문에 성공적으로 리턴한다.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//DB오류
		
	}
	public int withDraw(String userID,String clubName) {
		String SQL = "delete from user where userID = ? and clubName = ?";
		try {

			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userID);
			pstmt.setNString(2, clubName);
			return pstmt.executeUpdate(); //0이상의 값이 반환되기 때문에 성공적으로 리턴한다.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//DB오류
		
	}
}
