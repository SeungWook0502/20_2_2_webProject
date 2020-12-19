package FILE;

import java.sql.Connection;
import FILE.FileDTO;
import club.club;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FileDAO {

	private Connection conn;
	
	private ResultSet rs;
	
	public FileDAO() { //������ DB�� �����ؼ� DATA�� �������ų� DATA�� �ִ� DATA���� ��ü
		
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
	
	public int upload(String fileName,String fileRealName,String fileComment,String clubName) {
		
		String SQL="INSERT INTO FILE VALUES(?,?,?,?,?)";
		try {
			
			PreparedStatement pstmt = conn.prepareCall(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			pstmt.setString(3, fileComment);
			pstmt.setString(4, clubName);
			pstmt.setString(5, getDate());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
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
	
	public ArrayList<FileDTO> Gallery(String clubName) {
		
		String SQL="select * from file where clubName = ? order by fileDate desc";
		ArrayList<FileDTO> fileList = new ArrayList<FileDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, clubName);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				FileDTO fileDTO = new FileDTO();
				fileDTO.setFileName(rs.getString(1));
				fileDTO.setFileRealName(rs.getString(2));
				fileDTO.setFileComment(rs.getString(3));
				fileDTO.setClubName(rs.getString(4));
				fileDTO.setFileDate(rs.getString(5));
				
				
				fileList.add(fileDTO);
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return fileList;
		
	}
	public int delete(String fileRealName) {
		String SQL = "delete from file where fileRealName = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, fileRealName);
			return pstmt.executeUpdate(); //0�̻��� ���� ��ȯ�Ǳ� ������ ���������� �����Ѵ�.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//DB����
		
	}
}
