package survey;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import bbs.Bbs;

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
	
	public int getNext() {
		String SQL = "SELECT titlenum FROM surveytitle ORDER BY titlenum DESC"; 
		//내림차순, 가장 마지막에 쓰인 번호를 가져옴
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int writeTitle(String title) {
		String SQL = "INSERT INTO surveytitle VALUES (?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, title);
			pstmt.setInt(3, 1); // available
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
		String titleWithNoSpace = title.replaceAll(" ", "_"); // 테이블 명으로 공백은 넣을 수 없다. 가상현실_관련_경험_설문지
		System.out.println(titleWithNoSpace);
		// 테이블이 없다면
		if (!rs.next()) {
			// 테이블 생성
			Statement stmt = conn.createStatement();
			String sql = "create table " + titleWithNoSpace
					+ "("
					+ "surveyNum INT,"
					+ "surveyContent VARCHAR(300),"
					+ "surveyType INT,"
					+ "surveyScale INT,"
					+ "surveyMultiple INT,"
					+ "surveyDetail VARCHAR(100),"
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

	return 1; // 데이터베이스 오류
	}

	
	public int write(String title, int num, String content, int type){
		String titleWithNoSpace = title.replaceAll(" ", "_");
		String SQL = "INSERT INTO " + titleWithNoSpace + " VALUES (?, ?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setString(2, content);
			pstmt.setInt(3, type);
			pstmt.setInt(4, 0);
			pstmt.setInt(5, 0);
			pstmt.setString(6, "null");
			pstmt.setInt(7, 1);
			//rs = pstmt.executeQuery(); // insert문은 이게 필요없다.
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("db connect err : " + e);
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int write(String title, int num, String content, int type, int scale, int multiple, String detail, int surveyAvailable) {
		String titleWithNoSpace = title.replaceAll(" ", "_");
		String SQL = "INSERT INTO " + titleWithNoSpace + " VALUES (?, ?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  num);
			pstmt.setString(2, content);
			pstmt.setInt(3, type);
			pstmt.setInt(4, scale);
			pstmt.setInt(5, multiple);
			pstmt.setString(6, detail);
			pstmt.setInt(7, surveyAvailable);
			//rs = pstmt.executeQuery(); // insert문은 이게 필요없다.
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	
	public int ordering(String title){
		String titleWithNoSpace = title.replaceAll(" ", "_");
		//System.out.println(titleWithNoSpace);
		String SQL = "SELECT * FROM " + titleWithNoSpace + " ORDER BY surveynum asc"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); // insert문은 이게 필요없다.
			while(rs.next()){
				int num = rs.getInt("surveynum"); // 이렇게 해서 차례대로 끄네셈
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<String> getTitleList() { //여기서 타이틀 받으면.. 
		String SQL = "SELECT * FROM surveytitle WHERE titleAvailable = 1 ORDER BY titlenum ASC"; 
		//내림차순
		ArrayList<String> list = new ArrayList<String>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString(2);
				list.add(title);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public ArrayList<Survey> getList(String title) { //여기서 타이틀 받으면.. 
		String titleWithNoSpace = title.replaceAll(" ", "_");
		String SQL = "SELECT * FROM " + titleWithNoSpace + " ORDER BY surveynum ASC"; 
		//내림차순
		ArrayList<Survey> list = new ArrayList<Survey>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Survey survey = new Survey();
				survey.setSurveyNum(rs.getInt(1));
				survey.setSurveyContent(rs.getString(2));
				survey.setSurveyType(rs.getInt(3));
				survey.setSurveyScale(rs.getInt(4));
				survey.setSurveyMultiple(rs.getInt(5));
				survey.setSurveyDetail(rs.getString(6));
				survey.setSurveyAvailable(rs.getInt(7));
				
				list.add(survey);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
}
