<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="survey.SurveyDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Luvlet</title>
</head>
<body>
	<style>
.right_align {
	margin-right: 10px;
}
</style>
	<div class="container">
	<%
  		 String choiceArray = request.getParameter("choiceArray");
      	 String timeArray = request.getParameter("timeArray");
         String surveyTitle = request.getParameter("surveyTitle");
         String tTime = request.getParameter("totalTime");
	%>
	
	<script>
   	var tmp ="<%=choiceArray%>";
   	var tmp2 = "<%=timeArray%>";
   	var tmp3 = "<%=surveyTitle%>";
   	var tmp4 = "<%=tTime%>";
   	tmp3 += "_결과";
  	 document.write("choice Array: " + tmp + "<br>");
 	 document.write("Response Time Array: " + tmp2);
 	 document.write("Title: " + tmp3);
 	document.write("total Time: " + tmp4);

		
	</script>
	
	</div>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			SurveyDAO surveyDAO = new SurveyDAO();
			UserDAO userDAO = new UserDAO();
            String userName = userDAO.getName(userID);
            String userBirthday = userDAO.getBirthday(userID);
            String userGender = userDAO.getGender(userID);
            
            int result = surveyDAO.resultWrite(surveyTitle, userID, choiceArray, timeArray, userName,userBirthday,userGender);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('결과 쓰기에 실패했습니다.')");						
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();						
					script.println("<script>");
					script.println("location.href = 'selectSurvey.jsp'");
					script.println("</script>");
				}
		}
	%>
	
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	 <script>
   		 var addBtn = document.getElementById("addSurveyBtn");

   		 addBtn.onclick = function() {
  			 location.href = "addNewSurvey.jsp";
  		 }
  		 
   		 
    </script>
</body>
</html>