<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="survey.surveyTitle" %>
<%@ page import="survey.SurveyDAO" %>
<%@ page import="survey.Survey" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="surveytitle" class="survey.surveyTitle" scope="page"/>
<jsp:setProperty name="surveytitle" property="title"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="question.js"></script>
<title>Luvlet</title>
</head>
<body>
<script>
var questions = [];
</script>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
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
			<a class="navbar-brand" href="main.jsp">Luvlet</a>
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
				<%
					SurveyDAO surveydao = new SurveyDAO();
					//bbsDAO.countNum();
					ArrayList<Survey> list = surveydao.getList(surveytitle.getTitle());
				%>
	
	<% for(int i=1; i <list.size(); i++){
        	%><script>
        	<%-- alert(<%=i%>);
        	alert("<%=list.get(i).getSurveyContent()%>"); --%>
        	var question = new Question(<%=list.get(i).getSurveyNum()%>, "<%=list.get(i).getSurveyContent()%>", <%=list.get(i).getSurveyType()%>, <%=list.get(i).getSurveyScale()%>, <%=list.get(i).getSurveyMultiple()%>, "<%=list.get(i).getSurveyDetail()%>" );
       		questions.push(question);
        	</script>
        	<%
        }
        	%>
        	
  
	<div class="container">
		 <div id="survey">
		  <h1 align="center"><% out.println(surveytitle.getTitle()); %></h1>
		  <hr style="margin-bottom:20px">
        <h2><%=list.get(0).getSurveyContent()%></h2>
        <hr style="margin-bottom:20px">
       
        
        <p id="question"></p>
        <div align="center"><button id="startBtn"><span>START</span></button></div>
        <div id="buttons" align="center"></div>
        <!-- 
          <button id="backBtn"><span>이전 문항</span></button>
        	
        <hr style="margin-top: 50px">
        <footer>
          <p id="progress">Question x of y.</p>
          
        </footer> -->
      </div>
	</div>
	<%!
	public void printTest(int head, javax.servlet.jsp.JspWriter out) 
			throws ServletException 
			{ 
			try 
			{ 
				out.println(head); 
				
			} 
			catch (Exception e){} 
			} 

	%>

	
	<% String my="http://test.com"; 
		int questionIndexJAVA = 0;
		
		int a = 1;
		a = a + 1;
		
	%>
	<script>
	var myhome = "<%=my%>";
	//alert(myhome);
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
		var questionIndex = 1;
		var choiceArray = [];
		var score = 0;
   		 var startBtn = document.getElementById("startBtn");
   		 var mChoicesList = [];

   		 startBtn.onclick = function() {
   		  	var surveyHTML = "<h1 align=\"center\">" + "<%=surveytitle.getTitle()%>" + "</h1>";
   		  	
		  	surveyHTML += "<hr style=\"margin-bottom:20px\">";
		  	surveyHTML += "<h2 id=\"question\"></h2>";
		        
		 	surveyHTML += "<div id=\"buttons\" align=\"center\">";
		  	surveyHTML += "	<button id=\"btn0\"><span id=\"choice0\"></span></button>";
		 	surveyHTML += "	<button id=\"btn1\"><span id=\"choice1\"></span></button>";
			  surveyHTML += "	<button id=\"btn2\"><span id=\"choice2\"></span></button>";
			  surveyHTML += "	<button id=\"btn3\"><span id=\"choice3\"></span></button>";
			  surveyHTML += "	<button id=\"btn4\"><span id=\"choice4\"></span></button>";
			  surveyHTML += "</div>";
			          
			  surveyHTML += "<div id='backAndmultiBtn'>";
			  surveyHTML += "<button id=\"backBtn\"><span>이전 문항</span></button>";
			  surveyHTML += "</div>";      	
			  
			  surveyHTML += "<hr style=\"margin-top: 50px\">";
			  surveyHTML += "<footer>";
			  surveyHTML += "	<p id=\"progress\">Question x of y.</p>";
			  surveyHTML += "</footer>";
	
			  document.getElementById("survey").innerHTML = surveyHTML;
			  
			  populate();
   		 }
   		function populate() {
   		  /*
   			document.getElementById("totalNumber").innerHTML = quiz.questions.length;
   			*/
   			//alert(quiz.questionIndex);
   			var x=1;
   			var summ = questionIndex-x;
   		  if(questions.length === summ){
   			  href = "surveyResult";
   		    showScores();
   		    
   		  }
   		  else {
   		    //show question
   		    document.getElementById("question").innerHTML = questions[questionIndex-1].content;
   		 	if(1 === questions[questionIndex-1].multiple){ //중복 선택 가능할 때
   		 		document.getElementById("question").innerHTML += ' (중복 선택이 가능합니다.)';
			}

   		    //show choices
   		    //var choices = quiz.getQuestionIndex().choices;
   		    if(questions[questionIndex-1].type === 0){ //객관식
   		  		var detailList = questions[questionIndex-1].detail.split(',');
   		  		var surveyHTML = " ";
   		  		
   		  		for(var i = 0; i < questions[questionIndex-1].scale; i++){
   		  			if(1 === questions[questionIndex-1].multiple){
   		  				
   		  				surveyHTML += "<button id=\"btn" + i + "\" name=\"" + i +"\" ><span id=\"choice" + i + "\"></span></button>";
   		
   		  			}
   		  			else{
   		  				surveyHTML += "<button id=\"btn" + i + "\"><span id=\"choice" + i + "\"></span></button>";
   		  			}
   		  		}
   		  		document.getElementById("buttons").innerHTML = surveyHTML;
   		  		
   		  		if(detailList.length === questions[questionIndex-1].scale) {
   		  			for(var i = 0; i < questions[questionIndex-1].scale; i++){
   		  				document.getElementById("choice" + i).innerHTML = detailList[i];
   		  			}
   		  		}
   		  		else{
	   		  		for(var i = 0; i < questions[questionIndex-1].scale; i++){
					 	document.getElementById("choice" + i).innerHTML = i;
					 	guess("btn" + i, i);
			  		}
   		  		}
   		  		
   		  		if(1 === questions[questionIndex-1].multiple){ //중복 선택 가능할 때
   		  			document.getElementById("backAndmultiBtn").innerHTML = "<button id=\"backBtn\"><span>이전 문항</span></button>";
   		  			document.getElementById("backAndmultiBtn").innerHTML += '<button id=\"multipleBtn\" align="center"><span>다음 문항</span></button>';
   		  			multipleGuess(0, questions[questionIndex-1].scale);
   		  			
				}
   		  		else{
   		  			document.getElementById("backAndmultiBtn").innerHTML = "<button id=\"backBtn\"><span>이전 문항</span></button>";
   		  		}
   		  		
   		    }
   		    else { // 주관식
   		    	var surveyHTML = " ";
   		    	surveyHTML += '<form method="post" action="surveyResult.jsp">';
   		    	surveyHTML += '<h3 style="text-align: center;">주관식</h3>';
   		    	surveyHTML += '<div class="form-group">';
   		    	surveyHTML += '<input type="text" class="form-control" placeholder="내용을 입력해주세요." NAME="'+questions[questionIndex-1].num+'" maxlength="50">';
				surveyHTML += '</div>';
				surveyHTML += '<button id="btn0"><span id="choice0">다음 문항</span></button>';
				surveyHTML += '</form>'
				document.getElementById("buttons").innerHTML = surveyHTML;
				guess("btn0", 0);
   		    }
   			//surveyHTML += '<button name="title" id="title" value="subjective' +  questions[questionIndex-1].num + '><span>작성완료</span></button>';
   		    backButton();
   		    showProgress();
   		  }
   		  
   		}

   		function guess(id, idx) {
   		  var button = document.getElementById(id);
   		  
   		  button.onclick = function() {
   			if(choiceArray.length > questionIndex){
   			  choiceArray[questionIndex] = idx;
   		 	 }
   		  	else{
   			  score = score + idx;
   			  choiceArray.push(idx);
   		  	}
   		  	questionIndex++;
   			 
   		    populate();
   		  }
   		}
   		
   		function Switch(obj) {
   			obj.classList.toggle( 'btn0--isSwitched' );
   			
        }
   		
   		var onClick = 0;
   		var onClickList = [];
   		function multipleGuess(id, num) {
     		 var nextBtn = document.getElementById("multipleBtn");
     		 var btns = [];
     		 for(var i = 0 ;i < num; i++){
     		 	btns.push(document.getElementById("btn" + i));
     		 	onClickList.push(0);
     		 }
     		
     		 
     		 for(var i=0; i < num; i++) {
     			//alert(btns[i].name);
     			btns[i].addEventListener("click", function(){
     		       if(onClickList[this.name] === 0) {
     		    	   this.style.backgroundColor = "#57636e"; // btns[i]. style 하면 안됨
     		    	   
     		    	   onClickList[this.name] = 1;
     		    	}
     		       else {
     		    	  this.style.backgroundColor = "#778897";
    		    	   
    		    	   onClickList[this.name] = 0;
     		       }
     		    });
     		}
     		 
     		nextBtn.onclick = function() {
     			if(choiceArray.length > questionIndex){
     			  choiceArray[questionIndex] = -1; // -1 들어감 (복수선택이라는 뜻) 
     		 	 }
     		  	else{
     			  score = score + idx;
     			  choiceArray.push(idx);
     		  	}
     		  	questionIndex++;
     			 
     		    populate();
     		  }
     		}
	
   		function backButton() {
   			var backButton = document.getElementById("backBtn");
   			
   			backButton.onclick = function() {
   				if(questionIndex === 1) {
   					alert("This is first item of this survey.");
   				}
   				else {
   					questionIndex--;
   					populate();
   				}
   		    }
   		}

   		function showProgress() {
   		  var currentQuestionNumber = questionIndex;
   		  document.getElementById("progress").innerHTML = "Question " + currentQuestionNumber + " of " + questions.length;
   		}



   		function showScores() {
   		  var gameOverHtml = "<h1>Result</h1>";
   		  var sum = 0;
   		  //alert(quiz.choiceArray);
   		  for(var i = 0; i < choiceArray.length; i++){
   			  sum += choiceArray[i];
   		  }
   		  gameOverHtml += "<h2 id='score'>End. Thank you</h2>";
   		  document.getElementById("survey").innerHTML = gameOverHtml;
   		}

   </script>
</body>
</html>