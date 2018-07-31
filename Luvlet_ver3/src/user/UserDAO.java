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
			if (rs.next()) { // ���� ������ �ִٸ�
				if(rs.getString(1).equals(userPassword)){
					return 1; // �α��� ����
				}
				else 
					return 0; // ��й�ȣ ����ġ
			}
			return -1; // ���̵� ����
		} catch (Exception e){
			e.printStackTrace();
		}
	
		return -2; // ���� ����
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
			return pstmt.executeUpdate(); // ������ 0 �̻� ���� ����
		} catch (Exception e){
			e.printStackTrace();
		}
		return -1; // ���� ����
	}
	
	public String getName(String userID) {
	      String SQL = "SELECT userName FROM USER WHERE userID = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);
	         rs = pstmt.executeQuery();
	         if (rs.next()) { // ���� ������ �ִٸ�
	            
	               return rs.getString(1); // �α��� ����
	            }
	            else 
	               return "error"; // ��й�ȣ ����ġ
	         
	         
	      }catch (Exception e){
	         e.printStackTrace();
	      }
	   
	      return "error"; // ���� ����
	   }
	   public String getBirthday(String userID) {
	      String SQL = "SELECT userBirthday FROM USER WHERE userID = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);
	         rs = pstmt.executeQuery();
	         if (rs.next()) { // ���� ������ �ִٸ�
	            
	               return rs.getString(1); // �α��� ����
	            }
	            else 
	               return "error"; // ��й�ȣ ����ġ
	         
	         
	      }catch (Exception e){
	         e.printStackTrace();
	      }
	   
	      return "error"; // ���� ����
	   }
	   public String getGender(String userID) {
	      String SQL = "SELECT userGender FROM USER WHERE userID = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);
	         rs = pstmt.executeQuery();
	         if (rs.next()) { // ���� ������ �ִٸ�
	            
	               return rs.getString(1); // �α��� ����
	            }
	            else 
	               return "error"; // ��й�ȣ ����ġ
	         
	         
	      }catch (Exception e){
	         e.printStackTrace();
	      }
	   
	      return "error"; // ���� ����
	   }
	   
}
