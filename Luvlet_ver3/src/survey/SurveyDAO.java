package survey;

import java.io.BufferedWriter;
import java.io.FileWriter;
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
		try {
			String alreadyExisted = "SELECT * FROM surveytitle WHERE title = ?";
			pstmt = conn.prepareStatement(alreadyExisted);
			pstmt.setString(1, title);
			rs = pstmt.executeQuery();
			if (!rs.next()) {
				String SQL = "INSERT INTO surveytitle VALUES (?, ?, ?)";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext());
				pstmt.setString(2, title);
				pstmt.setInt(3, 1); // available
				// rs = pstmt.executeQuery(); // insert문은 이게 필요없다.
				pstmt.executeUpdate();
			}
			else{
				System.out.println("This survey is already existed!");
				return -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try{
		String titleWithNoSpace = title.replaceAll(" ", "_"); // 테이블 명으로 공백은 넣을 수 없다. 가상현실_관련_경험_설문지
		titleWithNoSpace = titleWithNoSpace.replaceAll("-", "_"); // - 이거는 데베 인식 x. 예)SCL-90-R -> SCL_90_R
		String tableSql = "SELECT table_name FROM information_schema.tables where table_schema = ? and table_name = ?";
		pstmt2 = conn.prepareStatement(tableSql);
		pstmt2.setString(1, "LUVLET");
		pstmt2.setString(2, titleWithNoSpace);

		rs = pstmt2.executeQuery();
		//System.out.println(titleWithNoSpace);
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
		else{
			System.out.println("This survey is already existed!");
			return -1;
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
		
		try{ // 결과 테이블 만들기
			String titleWithNoSpace = title.replaceAll(" ", "_"); // 테이블 명으로 공백은 넣을 수 없다. 가상현실_관련_경험_설문지_결과
			titleWithNoSpace += "_결과";
			String tableSql = "SELECT table_name FROM information_schema.tables where table_schema = ? and table_name = ?";
			pstmt2 = conn.prepareStatement(tableSql);
			pstmt2.setString(1, "LUVLET");
			pstmt2.setString(2, titleWithNoSpace);

			rs = pstmt2.executeQuery();
			//System.out.println(titleWithNoSpace);
			// 테이블이 없다면
			if (!rs.next()) {
				// 테이블 생성
				Statement stmt = conn.createStatement();
				String sql = "create table " + titleWithNoSpace
						+ "("
						+ "num INT,"
						+ "userID VARCHAR(30),"
						+ "choiceArray VARCHAR(500),"
						+ "timeArray VARCHAR(1000),"
						+ "PRIMARY KEY (userID)"
						+ ")";

				boolean re = stmt.execute(sql);
				stmt.close();
				//System.out.println(rs2);
			}
			else{
				System.out.println("This survey result table is already existed!");
				return -1;
			}
		}catch(Exception e) {
			System.out.println("db connect err : " + e);
		}

	return 1; // 데이터베이스 오류
	}

	public int getNextInResult(String title) {
		String titleWithNoSpace = title.replaceAll(" ", "_");
		titleWithNoSpace += "_결과";
		String SQL = "SELECT num FROM " + titleWithNoSpace +" ORDER BY num DESC"; 
		//내림차순, 가장 마지막에 쓰인 번호를 가져옴
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setString(1, titleWithNoSpace);
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

	public int resultWrite(String title, String userID, String choiceArray, String timeArray,String userName,String userBirthday,String userGender){
	      String titleWithNoSpace = title.replaceAll(" ", "_");
	      titleWithNoSpace += "_결과";
	      String SQL = "INSERT INTO " + titleWithNoSpace + " VALUES (?, ?, ?, ?)";
	      //String fileName = "C:\\result\\"+userID+"_"+userName+"_"+title+".txt";
	      String fileName = "C:\\Users\\수진\\Desktop\\뜰레링\\졸프\\surveyResult\\"+userID+"_"+userName+"_"+title+".txt";
	      int nextNum = getNextInResult(title);
	      try {
	         BufferedWriter fw = new BufferedWriter(new FileWriter(fileName, true));
	         fw.write("ID :"+userID+"\t");
	         fw.write("Name :"+userName+"\t");
	         fw.newLine();
	         fw.write("Birthday :"+userBirthday+"\t");
	         fw.write("Gender :"+userGender+"\t");
	         fw.newLine();
	         fw.newLine();
	         String [] choice = choiceArray.split(",");
	         String [] time = timeArray.split(",");
	         fw.write("num"+"\t");
	         fw.write("result"+"\t");
	         fw.write("reaction time");
	         fw.newLine();
	         for (int i=0;i<choice.length;i++)
	         {
	            fw.write((i+1)+"\t"+choice[i]+"\t"+time[i]);
	            fw.newLine();
	         }
	 
	         fw.close();
	         
	         PreparedStatement pstmt = conn.prepareStatement(SQL);
	         pstmt.setInt(1, nextNum);
	         pstmt.setString(2, userID);
	         pstmt.setString(3, choiceArray);
	         pstmt.setString(4, timeArray);
	         //rs = pstmt.executeQuery(); // insert문은 이게 필요없다.
	         return pstmt.executeUpdate();
	      } catch (Exception e) {
	         System.out.println("db connect err : " + e);
	         e.printStackTrace();
	      }
	      return -1; // 데이터베이스 오류
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
