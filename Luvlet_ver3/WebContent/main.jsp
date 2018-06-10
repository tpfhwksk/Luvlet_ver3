<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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
	<script>
		var itemArray = [ '머리가 아프다', '신경이 예민하고 마음의 안정이 안 된다',
				'쓸데없는 생각이 머리에서 떠나지 않는다', '어지럽거나 현기증이 난다', '성욕이 감퇴되었다',
				'다른 사람들이 못마땅하게 보인다', '누가 내 생각을 조정하는 것 같다',
				'다른 사람들이 나를 비난하는 것 같다', '기억력이 좋지 않다', '조심성이 없어서 걱정이다',
				'사소한 일에도 짜증이 난다', '가슴이나 심장이 아프다 ', '넓은 장소나 거리에 가면 두렵다',
				'기운이 없고 침체된 기분이다', '죽고 싶은 생각이 든다', '다른 사람은 듣지 못하는 헛소리가 들린다',
				'몸이나 마음이 떨린다', '사람들이란 믿을 것이 못 된다는 생각이 든다', '입맛이 없다',
				'울기를 잘 한다', '이성을 대하면 어색하거나 부끄럽다', '어떤 함정에 빠져 헤어날 수 없는 기분이 든다',
				'별 이유 없이 깜짝 놀란다', '자신도 걷잡을 수 없이 울화가 터진다', '혼자서 집을 나서기가 두렵다',
				'자책을 잘 한다', '허리가 아프다', '하고자 하는 일이 뜻대로 안되고 막히는 기분이다', '외롭다',
				'기분이 울컥하다', '매사에 걱정이 많다', '매사에 관심과 흥미가 없다', '두려운 느낌이 든다',
				'쉽게 기분이 상한다', '나의 사사로운 생각을 남이 아는 것 같다',
				'다른 사람들이 나를 이해 못하는 것 같다', '다른 사람들이 나를 싫어하거나 나에게 불친절하다고 느낀다',
				'매사에 정확을 기하느라고 일을 제때에 해내지 못한다', '심장(가슴)이 마구 뛴다',
				'구역질이 나거나 게운다', '내가 남보다 못한 것 같다(열등감을 느낀다)', '근육통 또는 신경통이 있다',
				'다른 사람들이 나를 감시하거나 나에 관해서 쑥덕거리는 것 같다', '잠들기가 어렵다',
				'매사를 확인하고 또 확인해야만 마음이 놓인다', '결단력이 부족하다', '자동차나 기차를 타기가 두렵다',
				'숨쉬기가 거북하다', '목이 화끈거리거나 찰 때(냉할 때)가 있다',
				'어떤 물건이나 장소 혹은 행위가 겁나서 피해야 했다', '마음속이 텅 빈 것 같다',
				'몸의 일부가 저리거나 찌릿찌릿하다', '목에 무슨 덩어리가 걸린 것 같다', '장래가 희망이 없는 것 같다',
				'주의 집중이 잘 안 되는 것 같다', '몸의 어느 부위가 힘이 없다', '긴장이 된다', '팔다리가 묵직하다',
				'죽음에 대한 생각을 한다', '과식한다', '남들이 나를 쳐다보거나 나에 대해 이야기하면 거북해진다',
				'내가 생각하는 것이 내 생각 같지 않다', '누구를 때리거나 해치고 싶은 충동이 생긴다',
				'새벽에 일찍 잠이 깬다', '만지고 셈하고 씻는 것과 같은 행동을 반복하게 된다', '잠을 설친다',
				'무엇을 때려 부수고 싶은 충동이 생긴다', '다른 사람들에게는 없는 생각이나 신념을 갖고 있다',
				'다른 사람과 함께 있을 때는 나의 언행에 신경을 쓰게 된다',
				'시장이나 극장처럼 사람이 많이 모인 곳에 가면 거북하다', '매사에 힘들다', '공포에 휩싸이는 때가 있다',
				'여러 사람이 있는 곳에서 먹고 마시기가 거북하다', '잘 다툰다', '혼자 있으면 마음이 안 놓이거나 두렵다',
				'다른 사람들이 내 공로를 인정하지 않는다', '사람들과 함께 있을 때에도 고독을 느낀다',
				'안절부절못해서 가만히 앉아 있을 수가 없다', '허무한 느낌이 든다',
				'낯익은 것들도 생소하거나 비현실적인 것처럼 느낀다', '고함을 지르거나 물건을 내 던진다',
				'사람들 앞에서 쓰러질까봐 걱정한다', '그냥 놓아두면 사람들에게 내가 이용당할 것 같다',
				'성 문제로 고민한다', '내 죄 때문에 벌을 받아야 한다', '무슨 일이든 조급해서 안절부절 못한다',
				'내 몸 어딘가가 멍들었다고 생각한다', '늘 남과 동떨어져 있는 느낌이다',
				'죄를 지었거나 잘못을 저질렀다고 생각한다', '내 마음 어딘가 이상하다고 생각한다' ];
		var autoIdx = 0; // for easy click
		function make_button(num) {

			document
					.write(' <input type="radio" class="right_align" name="item', num, '" value="0" style="margin-right:7px;"  >  ');
			document
					.write(' <input type="radio" class="right_align" name="item', num, '" value="1" style="margin-right:7px;" >  ');
			document
					.write(' <input type="radio" class="right_align" name="item', num, '" value="2" style="margin-right:7px;" >  ');
			document
					.write(' <input type="radio" class="right_align" name="item', num, '" value="3" style="margin-right:7px;" >  ');
			document
					.write(' <input type="radio" class="right_align" name="item', num, '" value="4" style="margin-right:7px;">  ');
			
			autoIdx += 5;
		}
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
			document.write("총합 :" + sum);
		}
	</script>
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
		<div class="jumbotron">
			<h1>
				<center>SCL-90-R</center>
			</h1>
			<p>◉ 지난 7일 동안(오늘을 포함해서) 아래 문제 때문에 얼마나 괴로워했는지를 가장 잘 나타낸 것 하나를 골라서
				( V )표해주십시오. 전혀(0점), 약간 (1점), 웬만큼 (2점), 꽤 (3점), 아주 (4점)</p>

			<form name="surveyresult" action="resultAction.jsp">
				<table border="1" width="100%" style="margin-right: 10%">
					<!--  <p>1. 머리가 아프다<script>make_button(1)</script></p>
				<p>2. 신경이 예민하고 마음의 안정이 안 된다 <script>make_button(2)</script></p>	-->
					<script>
						for (var i = 0; i < 10; i++) {
							document
									.write(
											"<tr><td width=\"70%\"><p>",
											i + 1,
											". ",
											itemArray[i],
											"</p></td><td width=\"30%\" align=\"center\"><p> <script>make_button(",
											i, ")<","/script></p></td></tr>");
						}
					
					</script>
					
				</table>
				<input type="button" class="btn btn-primary pull-right" value="결과보기"
					onclick="calc_result(10);">
			</form>
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/main.jpg">
				</div>
				<div class="item">
					<img src="images/main2.jpg">
				</div>
				<div class="item">
					<img src="images/main3.jpg">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a> <a class="right carousel-control" href="#myCarousel"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>