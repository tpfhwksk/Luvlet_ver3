package survey;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class surveyTitleDAO {
	private Connection conn;
	private ResultSet rs;
	
	public surveyTitleDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/LUVLET";
			String dbID = "root";
			String dbPassword = "dbzla8426";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int write(String titles) {
		String SQL = "INSERT INTO surveytitle VALUES (?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, titles);
			//rs = pstmt.executeQuery(); // insert문은 이게 필요없다.
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
