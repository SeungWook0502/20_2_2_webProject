package BBS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;

	private ResultSet rs;
	
	public BbsDAO() { //������ DB�� �����ؼ� DATA�� �������ų� DATA�� �ִ� DATA���� ��ü
		
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
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO�� �޴� �����Ͱ� ���⶧����
			//�����͸��� �з����ֱ� ���� pstmt�� method���� ���� �д�
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //DB����
	}

	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; //���������� ���峷����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO�� �޴� �����Ͱ� ���⶧����
			//�����͸��� �з����ֱ� ���� pstmt�� method���� ���� �д�
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //ù��° �Խù��� ���
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB����
	}
	public int write(String bbsTitle, String userID, String bbsContent,String clubName) {
		String SQL = "insert into bbs values(?,?,?,?,?,?,?)"; //���������� ���峷����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); //�����ۼ��� ��� Avaliable�� ���̿���(�����ֱ�)�Ѵ�
			pstmt.setString(7, clubName);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB����
	}
	
	public ArrayList<Bbs> getList(int pageNumber,String clubName){
		String SQL = "SELECT bbsID,bbsTitle,userID,bbsDate,bbsContent,bbsAvailable FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 AND clubName = ? order by bbsID DESC LIMIT 10"; //���������� ���峷����
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO�� �޴� �����Ͱ� ���⶧����
			//�����͸��� �з����ֱ� ���� pstmt�� method���� ���� �д�
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
		return list; //DB����
	}
	
	public boolean nextPage(int pageNumber,String clubName) {	//Paggingó���� ���� �Լ�
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 AND clubName = ?"; //���������� ���峷����
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO�� �޴� �����Ͱ� ���⶧����
			//�����͸��� �з����ֱ� ���� pstmt�� method���� ���� �д�
			pstmt.setInt(1, getNext()-(pageNumber - 1)*10);
			pstmt.setString(2, clubName);
			rs=pstmt.executeQuery();
			if(rs.next()) {	//������������ �Ѿ �� ����
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false; //DB����
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()) {	//������������ �Ѿ �� ����
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
		return null; //DB����
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
		return -1; //DB����
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
		return -1; //DB����
	
	}
}



