
function setting() {
	document.getElementById("totalNumber").innerHTML = quiz.questions.length;
}

function showMain() {
	  var gameMainHtml = "<h1>SCL-90-R</h1>";
	  gameMainHtml += "<h2>지난 7일 동안(오늘을 포함해서) 아래 문제 때문에 얼마나 괴로워했는지를 가장 잘 나타낸 것 하나를 골라서 선택해주십시오. </h2>";
	  gameMainHtml += "<div align=\"center\">";
	  gameMainHtml += "  <button id=\"startBtn\"><span>START</span></button>";
	  gameMainHtml += "</div>";
	  
	  document.getElementById("quiz").innerHTML = gameMainHtml;
	  
	  clickStart();
	}

function clickStart() {
	//alert(quiz.questionIndex);
	var button = document.getElementById("startBtn");
	  button.onclick = function() {
	    location.href = "index.html";
	  }
}

clickStart();