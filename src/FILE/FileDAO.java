package FILE;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class FileDAO {

	private Connection conn;
	
	public FileDAO() { //실제로 DB에 접속해서 DATA를 가져오거나 DATA를 넣는 DATA접근 객체
		
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
	
	public int upload(String fileName,String fileRealName,String fileComment) {
		
		String SQL="INSERT INTO FILE VALUES(?,?,?)";
		try {
			
			PreparedStatement pstmt = conn.prepareCall(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			pstmt.setString(3, fileComment);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
