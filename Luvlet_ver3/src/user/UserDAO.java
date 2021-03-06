package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
		
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) { // 나온 정보가 있다면
				if(rs.getString(1).equals(userPassword)){
					return 1; // 로그인 성공
				}
				else 
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch (Exception e){
			e.printStackTrace();
		}
	
		return -2; // 데베 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  user.getUserID());
			pstmt.setString(2,  user.getUserPassword());
			pstmt.setString(3,  user.getUserName());
			pstmt.setString(4,  user.getUserGender());
			pstmt.setString(5,  user.getUserEmail());
			pstmt.setString(6,  user.getUserBirthday());
			return pstmt.executeUpdate(); // 성공시 0 이상 숫자 리턴
		} catch (Exception e){
			e.printStackTrace();
		}
		return -1; // 데베 오류
	}
	
	public String getName(String userID) {
	      String SQL = "SELECT userName FROM USER WHERE userID = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);
	         rs = pstmt.executeQuery();
	         if (rs.next()) { // 나온 정보가 있다면
	            
	               return rs.getString(1); // 로그인 성공
	            }
	            else 
	               return "error"; // 비밀번호 불일치
	         
	         
	      }catch (Exception e){
	         e.printStackTrace();
	      }
	   
	      return "error"; // 데베 오류
	   }
	   public String getBirthday(String userID) {
	      String SQL = "SELECT userBirthday FROM USER WHERE userID = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);
	         rs = pstmt.executeQuery();
	         if (rs.next()) { // 나온 정보가 있다면
	            
	               return rs.getString(1); // 로그인 성공
	            }
	            else 
	               return "error"; // 비밀번호 불일치
	         
	         
	      }catch (Exception e){
	         e.printStackTrace();
	      }
	   
	      return "error"; // 데베 오류
	   }
	   public String getGender(String userID) {
	      String SQL = "SELECT userGender FROM USER WHERE userID = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);
	         rs = pstmt.executeQuery();
	         if (rs.next()) { // 나온 정보가 있다면
	            
	               return rs.getString(1); // 로그인 성공
	            }
	            else 
	               return "error"; // 비밀번호 불일치
	         
	         
	      }catch (Exception e){
	         e.printStackTrace();
	      }
	   
	      return "error"; // 데베 오류
	   }
	   
}
