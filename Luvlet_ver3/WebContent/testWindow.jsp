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
	<h1 align="center">MSSQ</h1>
	<hr style="margin-bottom:20px">
		<h2>5.	어렸을 때 (12세 이전에), 얼마나 자주 탔는지 체크해 주세요.</h2>
		<h2>자동차
		<button id="btn000"><span class="spanClass">전혀 아니다</span></button>
		<button id="btn000"><span class="spanClass""> 아니다</span></button>
		<button id="btn000"><span class="spanClass"">보통이다</span></button>
		<button id="btn000"><span class="spanClass"">그렇다</span></button>
		<button id="btn000"><span class="spanClass"">매우 그렇다</span></button>
		</h2>
		<h2>버스
		<button id="btn000"><span class="spanClass"">전혀 아니다</span></button>
		<button id="btn000"><span class="spanClass""> 아니다</span></button>
		<button id="btn000"><span class="spanClass"">보통이다</span></button>
		<button id="btn000"><span class="spanClass"">그렇다</span></button>
		<button id="btn000"><span class="spanClass"">매우 그렇다</span></button>
		</h2>
		<hr style="margin-bottom:20px">
	</div>
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