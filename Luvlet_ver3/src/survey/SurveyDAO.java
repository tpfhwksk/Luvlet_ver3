package survey;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SurveyDAO {
	private Connection conn;
	private ResultSet rs, rs2;
	private PreparedStatement pstmt, pstmt2;

	public SurveyDAO() {
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

	public int writeTitle(String title) {
		String SQL = "INSERT INTO surveytitle VALUES (?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			// rs = pstmt.executeQuery(); // insert문은 이게 필요없다.
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try{
		String tableSql = "SELECT table_name FROM information_schema.tables where table_schema = ? and table_name = ?";
		pstmt2 = conn.prepareStatement(tableSql);
		pstmt2.setString(1, "LUVLET");
		pstmt2.setString(2, title);

		rs = pstmt2.executeQuery();
		// 테이블이 없다면
		if (!rs.next()) {
			// 테이블 생성
			Statement stmt = conn.createStatement();
			String sql = "create table " + "abab"
					+ "("
					+ "surveyContent VARCHAR(50),"
					+ "surveyType INT,"
					+ "surveyScale INT,"
					+ "surveyMultiple INT,"
					+ "surveyDetail VARCHAR(50),"
					+ "surveyAvailable INT,"
					+ "PRIMARY KEY (surveyContent)"
					+ ")";

			boolean re = stmt.execute(sql);
			stmt.close();
			//System.out.println(rs2);
		}
	} catch(Exception e) {
		System.out.println("db connect err : " + e);
	}finally
	{
		try {
			if (rs != null)
				rs.close();
			if (pstmt2 != null)
				pstmt2.close();
			if (conn != null)
				pstmt2.close();
		} catch (Exception e) {
		}
	}

	return-1; // 데이터베이스 오류
	}


	public int write(String content, int type, int scale, int multiple, String detail) {
		String SQL = "INSERT INTO  VALUES (?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, content);
			//rs = pstmt.executeQuery(); // insert문은 이게 필요없다.
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

}
