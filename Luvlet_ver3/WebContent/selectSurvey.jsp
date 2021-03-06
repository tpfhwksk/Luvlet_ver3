<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="survey.SurveyDAO" %>
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
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<style>
.right_align {
	margin-right: 10px;
}
</style>
		
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="selectSurvey.jsp">Luvlet</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">main</a></li>
				<li><a href="bbs.jsp">BBS</a></li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">Connect<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">SignIn</a></li>
						<li><a href="join.jsp">Join</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">LogOut</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
	
		<div class="buttons" align="center">
		<form style="display:inline; margin:0px;" method="post" action="Survey.jsp">
		<!-- display:inline; margin:0px;가 form 태그와 addSurvye버튼 사이의 여백(줄바꿈)을 없애줌 -->
		<!-- 글자가 한 줄 넘어가면 정렬이 달라짐(그 버튼 살짞 밑으로 내려감) -->
		<!-- value에 다른 페이지로 보낼 값 설정 가능 -->
				<%
				SurveyDAO surveydao = new SurveyDAO();
				ArrayList<String> list = surveydao.getTitleList();
				for(int i = 0; i < list.size(); i++) {
				%>
          			<button name="title" id="title" value="<%=list.get(i)%>"><span class="btnClass"><%=list.get(i)%></span></button>
				<%	
					}
				%>
         	 
         </form> 
         <button id="addSurveyBtn"><span id="choice4">+</span></button>
          
        </div>
			
				<%-- <%
				SurveyDAO surveydao = new SurveyDAO();
				ArrayList<String> list = surveydao.getTitleList();
					for(int i = 0; i < list.size(); i++) {
				%>
				
					<p><%= list.get(i) %></p>
					<a href="view.jsp?surveyTitle=<%= list.get(i)%>"><%= list.get(i).replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a>
				<%	
					}
				%> --%>
	</div>
	<% String my="http://test.com"; %>
	<script>
	var myhome = "<%=my%>";
	//alert(myhome);
	</script>
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