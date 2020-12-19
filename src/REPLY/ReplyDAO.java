package REPLY;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import BBS.Bbs;

public class ReplyDAO {

	private Connection conn;
	private ResultSet rs;
	
	public ReplyDAO() { //������ DB�� �����ؼ� DATA�� �������ų� DATA�� �ִ� DATA���� ��ü
		
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
	
	public int writeReply(int bbsID, String userID,String comment) {
		String SQL = "insert into reply values(?,?,?,?,?)"; //���������� ���峷����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setInt(2, getNext(bbsID));
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, comment);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB����
	}
	
	public ArrayList<Reply> getList(int bbsID){
		String SQL = "SELECT userID, replyDate, comment, bbsID, replyID FROM reply WHERE bbsID = ? order by replyID ASC"; //���������� ���峷����
		ArrayList<Reply> list = new ArrayList<Reply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //BbsDAO�� �޴� �����Ͱ� ���⶧����
			//�����͸��� �з����ֱ� ���� pstmt�� method���� ���� �д�
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();
			while (rs.next()) {
				Reply reply = new Reply();
				reply.setUserID(rs.getString(1));
				reply.setReplyDate(rs.getString(2));
				reply.setComment(rs.getString(3));
				reply.setBbsID(rs.getInt(4));
				reply.setReplyID(rs.getInt(5));
				list.add(reply);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //DB����
	}
	
	public int getNext(int bbsID) {
		String SQL = "SELECT replyID FROM reply where bbsID = ? ORDER BY replyID DESC"; //���������� ���峷����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
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
	
	public int deleteReply(int bbsID,int replyID) {
		String SQL = "delete from reply where bbsID=? and replyID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setInt(2, replyID);
			return pstmt.executeUpdate(); //0�̻��� ���� ��ȯ�Ǳ� ������ ���������� �����Ѵ�.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//DB����
		
	}
	
}
