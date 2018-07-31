<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.*"%>
<%@ page import="survey.surveyTitle"%>
<%@ page import="survey.SurveyDAO"%>
<%@ page import="survey.Survey"%>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="surveytitle" class="survey.surveyTitle" scope="page" />
<jsp:setProperty name="surveytitle" property="title" />
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
var finalIndex = 0;
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
	<%
		SurveyDAO surveydao = new SurveyDAO();
		//bbsDAO.countNum();
		ArrayList<Survey> list = surveydao.getList(surveytitle.getTitle());
	%>

	<script>
				finalIndex = <%=list.size()%> - 1;
				//alert(finalIndex);
				</script>

	<%
		for (int i = 1; i < list.size(); i++) {
	%>
	<script>
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
			<h1 align="center">
				<%
					out.println(surveytitle.getTitle());
				%>
			</h1>
			<hr style="margin-bottom: 20px">
			<h2><%=list.get(0).getSurveyContent()%></h2>
			<hr style="margin-bottom: 20px">


			<p id="question"></p>
			<div align="center">
				<button id="startBtn">
					<span>START</span>
				</button>
			</div>
			<div id="buttons" align="center"></div>
			<!-- 
          <button id="backBtn"><span>이전 문항</span></button>
        	
        <hr style="margin-top: 50px">
        <footer>
          <p id="progress">Question x of y.</p>
          
        </footer> -->
		</div>
	</div>
	<%!public void printTest(int head, javax.servlet.jsp.JspWriter out) throws ServletException {
		try {
			out.println(head);

		} catch (Exception e) {
		}
	}%>


	<%
		String my = "http://test.com";
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
		var responseTimeArray = []; //반응시간
		var score = 0;
   		 var startBtn = document.getElementById("startBtn");
   		 var mChoicesList = [];
   		var tStart = new Date().getTime(); 

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
			 
			  surveyHTML += "</div>";      	
			  
			  surveyHTML += "<hr style=\"margin-top: 50px\">";
			  surveyHTML += "<footer>";
			  surveyHTML += "	<p id=\"progress\">Question x of y.</p>";
			  surveyHTML += "</footer>";
	
			  document.getElementById("survey").innerHTML = surveyHTML;
			  
			  populate();
   		 }
   		var finalIsClicked = 0;
   		function populate() {
   		  /*
   			document.getElementById("totalNumber").innerHTML = quiz.questions.length;
   			*/
   			//alert(quiz.questionIndex);
   			finalIsClicked = 0;
   			
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
   		  				surveyHTML += "<button id=\"btn" + i + "\" name=\"" + i +"\" width = (100/questions[questionIndex-1].scale)%><span class=\"spanClass\" id=\"choice" + i + "\"></span></button>";
   		  			}
   		  			else{
   		  				surveyHTML += "<button id=\"btn" + i + "\" width =(100/questions[questionIndex-1].scale)%><span id=\"choice" + i + "\"></span></button>";
   		  			}
   		  		}
   		  		document.getElementById("buttons").innerHTML = surveyHTML;
   		  		//document.getElementById("buttons").innerHTML += "<p float=left;>전혀 아니다</p>";
   		  		
   		  		for(var i = 0; i < questions[questionIndex-1].scale; i++){
   		  			if(questions[questionIndex-1].multiple === 0){ //한개만 선택가능 (버튼 일자로 나열)
   		  			 	if(questions[questionIndex-1].scale > 10){
                        	 var tmpBtn = document.getElementById('btn' + i);
                      		 tmpBtn.style.width = 100 / 6  + '%';
                      	}
   		  			 	else{
   		  			 		var tmpBtn = document.getElementById('btn' + i);
   		  					tmpBtn.style.width = 100 / (questions[questionIndex-1].scale + 1)  + '%';
   		  			 	}
   		  			}
   		  			else{ // 중복 선택(버튼 일자로 굳이 안해도 됨)
   		  				var tmpBtn = document.getElementById('btn' + i);
		  				tmpBtn.style.width = 120  + 'px';
   		  			}
   		  		}
   		  		
   		  		if(detailList.length === questions[questionIndex-1].scale) {
   		  			for(var i = 0; i < questions[questionIndex-1].scale; i++){
   		  				document.getElementById("choice" + i).innerHTML = detailList[i];
   		  				if(0 === questions[questionIndex-1].multiple){
   		  					guess("btn" + i, i);
   		  				}
   		  			}
   		  		}
   		  		else{
	   		  		for(var i = 0; i < questions[questionIndex-1].scale; i++){
					 	document.getElementById("choice" + i).innerHTML = i;
					
					 	guess("btn" + i, i);
			  		}
   		  		}
   		  		
   		  		if(1 === questions[questionIndex-1].multiple){ //중복 선택 가능할 때
   		  			document.getElementById("backAndmultiBtn").innerHTML = "<button id=\"backBtn\"><span class=\"spanClass\">이전 문항</span></button>";
   		  		
   		  			if(questionIndex === finalIndex){ //마지막 문항일 때
   		  				var gameOverHtml = "<button id=\"backBtn\"><span>이전 문항</span></button>";
	        			gameOverHtml += "<button class=\"resultSubmitBtn\" id=\"toResult\"><span>끝내기</span></button>"; 
	        			document.getElementById("backAndmultiBtn").innerHTML = gameOverHtml;
   		  			}
   		  			else{
   		  				document.getElementById("backAndmultiBtn").innerHTML += '<button id=\"multipleBtn\" ><span class=\"spanClass\">다음 문항</span></button>';
   		  			}
   		  			multipleGuess(questions[questionIndex-1].num, questions[questionIndex-1].scale);
   		  			//var nextBtn = document.getElementById("multipleBtn");
   		  			//multipleBtn.style.
					
   		  		}
   		  		else{
   		  			document.getElementById("backAndmultiBtn").innerHTML = "<button id=\"backBtn\"><span class=\"spanClass\">이전 문항</span></button>";
   		  			//alert("이전");
   		  			if(questionIndex === finalIndex){ //마지막 문항일 때 
		        		var gameOverHtml = "<button id=\"backBtn\"><span class=\"spanClass\">이전 문항</span></button>";
		        		gameOverHtml += "<button class=\"resultSubmitBtn\" id=\"toResult\"><span class=\"spanClass\">끝내기</span></button>"; 
		        		document.getElementById("backAndmultiBtn").innerHTML = gameOverHtml;
		        		document.getElementById("toResult").addEventListener("click", js);
		        		  function js() {
		        		    if(finalIsClicked === 0){
		        		    	alert("답을 선택해주세요.")
		        		    }
		        		    else{
		        		    	 showScores();
		        		    }
		        		  }
						/*
		           		document.send.choiceArray.value=choiceArray; */
		           		
		           		//document.send.choiceArr.value=choiceArray;
   		  			}
   		  			//alert("이후");
   		  		}
   		  		
   		  		
   		    }
   		    else { // 주관식
   		    	/* var surveyHTML = " ";
   		    	surveyHTML += '<form method="post" action="surveyResult.jsp">';
   		    	surveyHTML += '<h3 style="text-align: center;">주관식</h3>';
   		    	surveyHTML += '<div class="form-group">';
   		    	surveyHTML += '<input type="text" class="form-control" placeholder="내용을 입력해주세요." NAME="'+questions[questionIndex-1].num+'" maxlength="50">';
				surveyHTML += '</div>';
				surveyHTML += '<button id="btn0"><span id="choice0">다음 문항</span></button>';
				surveyHTML += '</form>'
				document.getElementById("buttons").innerHTML = surveyHTML;
				
				guess("btn0", 0); */
				
				// 동환 부분 시작
		         var surveyHTML = " ";
		            //surveyHTML += '<form method="post" action="surveyResult.jsp">';
		            //surveyHTML += '<form>';
		         surveyHTML += '<h3 style="text-align: center;">주관식</h3>';
		         surveyHTML += '<div class="form-group">';
		         surveyHTML += '<input type="text" id="input" class="form-control" placeholder="내용을 입력해주세요." NAME="'+questions[questionIndex-1].num+'" maxlength="50">';
		         surveyHTML += '</div>';
		         //surveyHTML += '<button id="btn0"><span id="choice0">다음 문항</span></button>';
		         //surveyHTML += '</form>';
		         document.getElementById("buttons").innerHTML = surveyHTML;
		         //s_guess("btn0", 0);
		         //동환 끝
		         
				 if(questionIndex != 1){
					document.getElementById("backAndmultiBtn").innerHTML = "<button id=\"backBtn\"><span class=\"spanClass\">이전 문항</span></button>";
				 }
				 else{
					document.getElementById("backAndmultiBtn").innerHTML = "";
				 }
				 document.getElementById("backAndmultiBtn").innerHTML += '<button id=\"SAnextBtn\" ><span class=\"spanClass\">다음 문항</span></button>';
				 s_guess("SAnextBtn", 0);
			}
   			//surveyHTML += '<button name="title" id="title" value="subjective' +  questions[questionIndex-1].num + '><span>작성완료</span></button>';
   		    backButton();
   		    showProgress();
   		  }
   		  
   		}
   		
   		function s_guess(id, idx) { // 주관식
            
            if(questionIndex === finalIndex){ //마지막 문항
               var button = document.getElementById(id); // 다음 문항 버튼
               var nStart = new Date().getTime(); 
               
               button.onclick = function() {
               
                  var input =document.getElementById("input").value;
                  if(input.trim() == "" || input == null){ //입력이 공백인 경우
                	  alert("한 글자 이상 입력해주십시오");
                	  populate();
                  }
                  //alert(input);
                  //alert(questionIndex);
                  else{ // 입력이 공백이 아닌 경우
                 	var nEnd =  new Date().getTime();      //종료시간 체크(단위 ms)
               	  	var nDiff = nEnd - nStart;      //두 시간차 계산(단위 ms)
                  	if(finalIsClicked === 1 || choiceArray.length === questionIndex){
                    	 choiceArray[questionIndex - 1] = input;
                      	 responseTimeArray[questionIndex - 1] = nDiff + "ms";
                 	}
                  	else{
                  	     choiceArray.push(input);
                    	 responseTimeArray.push(nDiff + "ms");
                  	}
                       
                       //questionIndex++;
                  	finalIsClicked = 1;
                  	this.style.backgroundColor = "#57636e";
                  	var btns = [];
                  	for(var i = 0 ;i < questions[questionIndex-1].scale; i++){
                        btns.push(document.getElementById("btn" + i));
                  	}
                  	for(var i = 0; i < questions[questionIndex-1].scale; i++){
                        if(idx != i){
                           btns[i].style.backgroundColor = "#778897";
                        }
                  	}
                  }
                }
            }
            else{
                 var button = document.getElementById(id);
                 var nStart = new Date().getTime(); 
         
                 button.onclick = function() {
                   var nEnd =  new Date().getTime();      //종료시간 체크(단위 ms)
                   var nDiff = nEnd - nStart;      //두 시간차 계산(단위 ms)
                   var input =document.getElementById("input").value;
                   
                   if(input.trim() == "" || input == null){ // 입력 값이 공백일 경우
                 	  alert("한 글자 이상 입력해주십시오");
                 	  populate();
                   }
               
                   //alert(typeof input);
                   else{ // 입력 값이 공백이 아닌 경우
                  	  if(choiceArray.length > questionIndex || choiceArray.length === questionIndex ){
                   
                      	choiceArray[questionIndex - 1] = input;
                      	responseTimeArray[questionIndex - 1] = nDiff + "ms";
                  		//alert("case1"+ responseTimeArray.length);
                      }
                      else{
                        score = score + idx;
                    	choiceArray.push(input);
                    	responseTimeArray.push(nDiff + "ms");
                  		//alert("case2"+responseTimeArray.length);
                      }
                      questionIndex++;
             
                      //alert("popul");
                      //alert(nDiff + "ms");
                      populate();
                   }
                 }
            }
         }
		
   		function guess(id, idx) { // btn0, 0
   			if(questionIndex === finalIndex){
   			
   				var button = document.getElementById(id);
   			
   				var nStart = new Date().getTime(); 

   				button.onclick = function() {
   					var nEnd =  new Date().getTime();      //종료시간 체크(단위 ms)
                	var nDiff = nEnd - nStart;      //두 시간차 계산(단위 ms)

   		   		  	if(finalIsClicked === 1 || choiceArray.length === questionIndex){
   		   		  		choiceArray[questionIndex - 1] = idx;
   		   		 		responseTimeArray[questionIndex - 1] = nDiff + "ms";
   		   		  	}
   		   		  	else{
 		   			  	choiceArray.push(idx);
 		   				responseTimeArray.push(nDiff + "ms");
   		   		  	}
   		   		  	
   		   		  	//questionIndex++;
   		   		  	finalIsClicked = 1;
   		   			this.style.backgroundColor = "#57636e";
   		   			var btns = [];
   		   			for(var i = 0 ;i < questions[questionIndex-1].scale; i++){
   	     		 		btns.push(document.getElementById("btn" + i));
   	     		 	
   	     		 	}
   	     			 for(var i = 0; i < questions[questionIndex-1].scale; i++){
   	     				 if(idx != i){
   	     					 btns[i].style.backgroundColor = "#778897";
   	     			 	}
   	     			 }
   	     	 	}
   			}
   			else{
   		  		var button;
   		  		var etcButton;
   		  		var nStart = new Date().getTime(); 
   		  		
   		  		//
   				var spanDetail = document.getElementById('choice' + idx).innerHTML;
   				//alert(spanDetail); 잘 나옴
   				if(spanDetail === "기타"){
   					etcButton = document.getElementById(id);
   					
   					etcButton.onclick = function(){ //기타 버튼
   		   				
   	   					this.style.backgroundColor = "#57636e";
   	   					var etcHTML = '<div class="form-group">';
   	   		        	etcHTML += '<input type="text" id="input" class="form-control" placeholder="기타" NAME="'+questions[questionIndex-1].num+'" maxlength="50">';
   	   		         	etcHTML += '</div>';
   	   		         	document.getElementById("buttons").innerHTML += etcHTML;
   	   		         	document.getElementById("backAndmultiBtn").innerHTML += '<button id=\"SAnextBtn\" ><span class=\"spanClass\">다음 문항</span></button>';
   					 	
   	   		         
   	   		         	
   	   		    		//기타 버튼을 선택해서 주관식 창이 나타나더라도 다른 버튼(뒤로가기 버튼 포함) 선택하면 바로 다음 문항으로 넘어갈 수 있게함
   	   		     		for(var i = 0; i < questions[questionIndex-1].scale; i++){ 
 		  					if(0 === questions[questionIndex-1].multiple){
 		  						guess("btn" + i, i);
 		  					}
 		  				}
                  		backButton();
                  		
                  		s_guess("SAnextBtn", 0);
   	   				}
   				}
   				else{
   					button = document.getElementById(id);
   					
   					button.onclick = function() {
   	   		 			var nEnd =  new Date().getTime();      //종료시간 체크(단위 ms)
   	   		 			var nDiff = nEnd - nStart;      //두 시간차 계산(단위 ms)
   	   		 			
   	   		 			
   	   					if(choiceArray.length > questionIndex || choiceArray.length === questionIndex){
   	   					  choiceArray[questionIndex - 1] = idx; 
   	   					  responseTimeArray[questionIndex - 1] = nDiff + "ms";
   	   		 	 		}
   	   		  			else{
   	   					  score = score + idx;
   	   					  choiceArray.push(idx);
   	   					  responseTimeArray.push(nDiff + "ms");
   	   		  			}
   	   		  			questionIndex++;
   	   			 
   	   		 			//alert("popul");
   	   					//alert(nDiff + "ms");
   	   		   			 populate();
   	   		 		 }
   				}
   			}
   		}
   		
   		var onClick = 0;
   		var onClickList = [];
   		function multipleGuess(surveynum, num) {
   			 if(questionIndex === finalIndex){
   				var nextBtn = document.getElementById("toResult"); // 끝내기 눌렀을 때
   				
   			 }
   			 else{
     		 	var nextBtn = document.getElementById("multipleBtn");
   			 }
     		 
     		 var nStart = new Date().getTime();
     		
     		 var btns = [];
     		 for(var i = 0 ;i < num; i++){
     		 	btns.push(document.getElementById("btn" + i));
     		 	//onClickList.push(0);
     		 }
     		
     		 var isNew = 1;
     		 for(var i = 0; i < mChoicesList.length; i++){
     			 if(mChoicesList[i].num === surveynum){
     				 isNew = 0;
     				 var choices = mChoicesList[i].choiceList;
     				 for(var j = 0; j < choices.length; j++){
     					 btns[choices[j]].style.backgroundColor = "#57636e";
     				 }
     			 }
     		 }
     		 if(isNew === 1){
     			onClickList = [];
     			for(var i = 0 ;i < num; i++){
         		 	onClickList.push(0);
         		 }
     		 }
     		 
     		 for(var i=0; i < num; i++) {
     			//alert(btns[i].name);
     			btns[i].addEventListener("click", function(){
     		       if(onClickList[this.name] === 0) { //클릭안한거 클릭
     		    	   this.style.backgroundColor = "#57636e"; // btns[i]. style 하면 안됨
     		    	   
     		    	   onClickList[this.name] = 1;
     		    	}
     		       else {
     		    	  this.style.backgroundColor = "#778897"; //클릭 돼있는거 다시 클릭해서 해제시키기
    		    	   
    		    	   onClickList[this.name] = 0;
     		       }
     		    });
     		}
     		 
     		 var atleastOneBtn = 0;
     		nextBtn.onclick = function() {
     			
     			
     			  var selectedBtnNum = []; 
     			  for(var i = 0; i < btns.length; i++){
     				  if(onClickList[i] === 1){
     					  selectedBtnNum.push(i);
     					 atleastOneBtn = 1;
     				  }
     			  }
     			  if(atleastOneBtn === 0){
     				  alert("한 개 이상 선택하세요.");
     				  onclickList = [];
     				  for(var i = 0; i < mChoicesList.length; i++){
       				  	if(mChoicesList[i].num === surveynum){
       					  mChoicesList[i].choiceList = [];
       				  	}
       			 	 }
     				  populate();
     			  }
     			  else{
     				  var chk = 0;
     				  var tmp = new multipleChoice(surveynum, selectedBtnNum); // 몇번째 문제에서 몇번의 버튼들이 선택되었는지
     				  
     				  //alert(selectedBtnNum);
     				  var x = "_";
     				 for(var i = 0; i < selectedBtnNum.length; i++){
     					if(choiceArray.length > questionIndex){ // 다시 돌아와서 선택한 경우
       	     			  //choiceArray[questionIndex] += "_" + selectedBtnNum[i]; // -1 들어감 (복수선택이라는 뜻) 
       	     			  x += selectedBtnNum[i] + "_";
       	     		 	 }
       	     		  	else{
       	     		  	 x += selectedBtnNum[i] + "_";  
       	     		  	}	
     				 }
     				var nEnd =  new Date().getTime();
    				var nDiff = nEnd - nStart;      //두 시간차 계산(단위 ms)
    				var tDiff = nEnd - tStart;
     				if(choiceArray.length > questionIndex){
     				 	choiceArray[questionIndex - 1] = x;
     				 	responseTimeArray[questionIndex - 1] = nDiff + "ms";
     				}
     				else{
     					choiceArray.push(x);
     					responseTimeArray.push(nDiff + "ms");
     				}
     					 
     				  for(var i = 0; i < mChoicesList.length; i++){
        				  if(mChoicesList[i].num === surveynum){
        					  mChoicesList[i].choiceList = selectedBtnNum;
        					  chk = 1;
        				  }
        			  }
     				  if(chk === 0){
     				  	mChoicesList.push(tmp);
     				  }
     				 questionIndex++;
     				 //alert(mChoicesList[0].choiceList);
     		   		//alert(nDiff + "ms");
     				populate();
     			  }
     		  	}
     		  	//questionIndex++;
     			 
     		    //populate();
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


		function mainLink(){
			location.href = "selectSurvey.jsp";
		}
   		
   		function showScores() {
   		  var title = "<%=surveytitle.getTitle()%>"; // 무조건 따옴표안에 필수
   		  var gameOverHtml = "<h1>설문조사가 모두 끝났습니다.</h1>";
   		  gameOverHtml += "<h2>정말로 제출하시겠습니까?</h2>";
   		  gameOverHtml += "<br>";
   		  var sum = 0;
   		  
   		  alert(choiceArray);
   		  for(var i = 0; i < choiceArray.length; i++){
   			  sum += choiceArray[i];
   		  }
   			var nEnd =  new Date().getTime(); 
   			var tDiff = nEnd - tStart;
   		  //alert(sum);
        	gameOverHtml +='<form name ="send" action="resultAction.jsp" method = "post">';
        	gameOverHtml +='<input type ="hidden" name="choiceArray" value="">';
        	gameOverHtml +='<input type ="hidden" name="timeArray" value="">';
        	gameOverHtml +='<input type ="hidden" name="surveyTitle" value="">';
        	gameOverHtml +='<input type ="hidden" name="totalTime" value="">';
        	gameOverHtml +='<button class="reallySubmitBtn" name="sbm" id="sbm" value="choiceArr"><span class="spanClass">제출하기</span></button>';
        	gameOverHtml +='<button class="reallySubmitBtn" name="back" id="back" onclick="window.location.href=\'selectSurvey.jsp\'"><span class="spanClass">돌아가기</span></button>';
        	gameOverHtml +="</form>";
   			
   	
   			
   		  	document.getElementById("survey").innerHTML = gameOverHtml;
   		  	
   		 backBtn = document.getElementById("back");
			backBtn.addEventListener("click", function(){
				window.location.href = "selectSurvey.jsp";
			})
   		  	
   			document.send.choiceArray.value=choiceArray;
   			document.send.timeArray.value=responseTimeArray;
   			document.send.surveyTitle.value = title;
   			document.send.totalTime.value = tDiff;
   		  
   		}
   		
   		function saveFile(path, content, bool){
   			try{
   				
   				var file = new java.io.File(path);
   				if(!file.exists()){
   					return null;
   				}
   				var fw = new java.io.FileWriter(file,bool);
   				var bw = new java.io.BufferedWriter(fw);
   				var str = new java.lang.String(content);
   				bw.write(str);
   				bw.close();
   				fw.close();
   			} catch(e){
   				clientMessage(e);
   			}
   		}

   		function makeFolder(path){
   			try{
   				var file = new java.io.File(path);
   				if(!file.exists()){
   					file.mkdir();
   					print(" " +path+" 으로 디렉토리 생성 완료");}
   				else{}
   			}
   			catch(e){
   				clientMessage(e);
   			}
   		}
   		
   		function makeFile(path){
   			try {
   				var file = new java.io.File(path);
   				alert("dddd");	
   				if(file.createNewFile()){
   					clientMessage(" " + path + " 으로 파일 생성 완료");
   					//alert("dddd");	
   				}
   				else {}
   				
   			} catch(e) {
   				clientmessage(e);
   			
   			}
   		}
   		
   </script>
</body>
</html>