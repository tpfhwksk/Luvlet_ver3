var file = document.querySelector('#getfile');
var items = [];
var choiceList = ["전혀", "약간", "웬만큼", "꽤", "아주"]; // 이것도 받을 수 있음.

var tmpQuestions = [];
var questions = []; // for new Question(tmpQuestions[i], choiceList)
var quiz; // for new Quiz(questions);

file.onchange = function() {
	var fileList = file.files;
	
	var reader = new FileReader();
	reader.readAsText(fileList[0]);
	reader.onload = function() {
		var result = reader.result;
		var s_result = result.split('*');
		var title = s_result[0];
		var descHTML = "<h1><center>" + title + "</center></h1>";
		
		// document.write("<h1><center>"+s_result[0]+"</center></h1>");
		var sub_title = s_result[1];
		sub_title = sub_title.replace(/\r\n/g, '#');
		sub_title = sub_title.split('#');
		// document.write("<p>");
		var tmp = "";
		for (var i = 0; i < sub_title.length; i++) {

			if (sub_title[i] != null && sub_title[i] != ""){
				 //document.write(sub_title[i] );
				 tmp += sub_title[i];
			}
		}
		
		descHTML += "<h2>" + tmp + "</h2>";
		
		var questionList = s_result[2].replace(/\r\n/g, '#');
		questionList = questionList.split('#');
		for (var i = 0; i < questionList.length; i++) {
			if (questionList[i] != null && questionList[i] != ""){
				tmpQuestions.push(questionList[i]);
			}
		}
		//alert(tmpQuestions);
		
		
		for(var i = 0; i < tmpQuestions.length; i++) {
			//var question = new Question(tmpQuestions[i], choiceList);
			questions.push(tmpQuestions[i]);
		}
		
		//quiz = new Quiz(questions);
		
		descHTML += "<div class=\"buttons\" align=\"center\">";
		descHTML += "<button id=\"startBtn\"><span>START</span></button>";
		descHTML += "</div>";
		document.getElementById("survey").innerHTML = descHTML;
		
		surveyStart();
		
	};
};

function calc_result(cnt) {

	var sum = 0;
	var item = "item";
	for (var i = 0; i < cnt; i++) {

		var chk_radio = document.getElementsByName(item + String(i));
		var result = null;
		for (var j = 0; j < chk_radio.length; j++) {

			if (chk_radio[j].checked == true) {
				result = chk_radio[j].value;
				sum = sum + Number(result);
			}
		}
		if (result == null) {
			alert("선택하지 않은 설문이 있습니다");
			return;
		}

	}
	return sum;
	//document.write("총합 :" + sum);
}

function resultBtnClick() {
	  var button = document.getElementById("resultBtn");
	  
	  button.onclick = function() {
		  var gameOverHtml = "<h1>Result</h1>";
		  var sum = calc_result(questions.length);
		  gameOverHtml += "<h2 id='score'> Your scores: " + sum + "</h2>";
		  document.getElementById("survey").innerHTML = gameOverHtml;
	  }
}

// 숫자 0클릭해도 라디오 버튼 클릭 되게
function surveyStart() {
	var button = document.getElementById("startBtn");
	  
	  button.onclick = function() {
		  var surveyHTML = "<form name=\"surveyresult\">";
		  surveyHTML += "	  <table border=\"1\" width=\"100%\" style=\"margin-right: 10%\">";
		  var autoIdx = 0;
		  for(var i = 0; i < questions.length; i++){
			  //alert(questions[i]);
			  surveyHTML += "<tr><td width=\"70%\"><p>" + questions[i] + "</p></td>";
			  /*for(var j = 0; j < 5; j++){
				  surveyHTML += '<input type="radio" class="right_align" name="item', i , '" value=', j , ' style="margin-right:7px;>';
			  }*/
			  surveyHTML += "<td width=\"30%\" align=\"center\"><p>";
			  surveyHTML += '<input type="radio" class="right_align" name="item' + i + '" id="' + (autoIdx + 0) + '" value="0" style="margin-right:7px;">';
			  surveyHTML += '<label for="' + (autoIdx + 0) + '">0</label>';
			  surveyHTML += '<input type="radio" class="right_align" name="item' + i + '" id="' + (autoIdx + 1) +'" value="1" style="margin-right:7px;">';
			  surveyHTML += '<label for="' + (autoIdx + 1) + '">1</label>';
			  surveyHTML += '<input type="radio" class="right_align" name="item' + i + '" id="' + (autoIdx + 2) +'" value="2" style="margin-right:7px;">';
			  surveyHTML += '<label for="' + (autoIdx + 2) +'">2</label>';
			  surveyHTML += '<input type="radio" class="right_align" name="item' + i + '" id="' + (autoIdx + 3) +'" value="3" style="margin-right:7px;">';
			  surveyHTML += '<label for="' + (autoIdx + 3) +'">3</label>';
			  surveyHTML += '<input type="radio" class="right_align" name="item' + i + '" id="' + (autoIdx + 4) +'" value="4" style="margin-right:7px;">';
			  surveyHTML += '<label for="' + (autoIdx + 4) +'">4</label>';
			  
			  surveyHTML += "</p></td></tr>";
			  autoIdx += 5;
		  }
		  
		  surveyHTML += "	</table>";
		  
		  //surveyHTML += '	<input type="button" class="btn btn-primary pull-right" value="결과보기" onclick="calc_result(' + questions.length + ');">';
		  surveyHTML += '	<button class="btn btn-primary pull-right" id="resultBtn"><span>결과보기</span></button>';

		  
		  surveyHTML += "</form>";
		  
		  document.getElementById("survey").innerHTML = surveyHTML;
		  
		  resultBtnClick();
		  
	  }
}

