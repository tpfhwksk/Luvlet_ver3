package fileUpload;

import java.io.*;
import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import survey.Survey;
import survey.SurveyDAO;

public class fileUploading {
	private String filePath;
	
	public int fileInput(String path){
		List<Survey> survey = new ArrayList<Survey>();
	      try {
	         File file = new File(path);
	         BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF8"));

	         // BufferedReader in =new BufferedReader( new FileReader(file));
	         String s;
	         String s_title = new String();
	         int num = 0;
	         String s_detail = new String();

	         int cnt = 0;

	         while ((s = in.readLine()) != null) {

	            if (s.equals("*")) {
	               ++cnt;
	               if (cnt == 3) {
	                  survey.add(new Survey(s_detail, num));
	               }
	               continue;
	            }
	            if (cnt == 0) {

	               s_title += s;

	            } else if (cnt == 1) {
	               num = Integer.parseInt(s);

	            } else if (cnt == 2) {
	               s_detail += s;

	            } else if (cnt == 3) {

	               String[] question;
	               question = s.split("@");
	               int type = 1;
	               int scale;
	               String[] detail = new String[100];
	               int multiple = 0;

	               if (question[1].equals("LS")) {
	                  scale = Integer.parseInt(question[2]);
	                  type = 0;
	                  if (question[3].equals("M")) {
	                     multiple = 1;
	                  }
	                  if (question.length > 4) {
	                     // detail = question[4].split(",");
	                     survey.add(new Survey(question[0], type, scale, multiple, question[4]));

	                  } else {
	                     String d_detail = "";
	                     for (int i = 0; i < scale; i++) {

	                        String tmp = Integer.toString(i);
	                        d_detail = d_detail + tmp;

	                     }
	                     survey.add(new Survey(question[0], type, scale, multiple, d_detail));
	                  }

	                  /*
	                   * System.out.print("title :" + question[0]);
	                   * System.out.print("  type :" + question[1] + " " +
	                   * type); System.out.print("  scale :" + scale);
	                   * System.out.print("  multiple :" + question[3] + " " +
	                   * multiple);
	                   * 
	                   * System.out.println();
	                   */
	               } else {
	                  survey.add(new Survey(question[0], type));
	                  /*
	                   * System.out.print("title :" + question[0]);
	                   * System.out.print("  type :" + question[1] + " " +
	                   * type); System.out.println();
	                   */}

	            }

	         }
	         s_title = s_title.substring(1);
	         System.out.println(s_title);
	         
	         SurveyDAO surveydao = new SurveyDAO();
	         int result = surveydao.writeTitle(s_title); // 제목 데이터베이스 surveytitle 테이블에 따로 넣기
	         if(result == -1){
	        	System.out.println("write failed");
	        	return -1; // 
	         }
	         
	         
	         System.out.println(survey.get(0).getSurveyContent());
	         System.out.println("문항 수 : " + survey.get(0).getSurveyType());
	         
	         
	         
	         
	         for (int i = 1; i < survey.size(); i++) {

	            Survey tmp = survey.get(i);
	            if (tmp.getSurveyType() == 0) {
	               System.out.print("문제 : " + tmp.getSurveyContent()); 
	               System.out.print("  타입 : " + tmp.getSurveyType());
	               System.out.print("  스케일 : " + tmp.getSurveyScale());
	               System.out.print("  복수 : " + tmp.getSurveyMultiple());
	               System.out.print("  세부 : " + tmp.getSurveyDetail());
	               System.out.println();
	            } else {
	               System.out.print("문제a : " + tmp.getSurveyContent());
	               System.out.print("  타입 : " + tmp.getSurveyType());
	               System.out.println();
	            }
	         }
	         in.close();
	         System.out.println(survey.size());
	      } catch (FileNotFoundException e) {
	         e.printStackTrace();
	      } catch (IOException e) {
	         e.printStackTrace();
	      } finally {

	      }
	      return 1;
	}
}
