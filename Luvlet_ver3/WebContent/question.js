 function Research(title, num, detail, questions) {
         this.title = title;//설문 제목
         this.num = num;//설문지 문항 수
         this.detail = detail;// 설문지  세부 설명
         this.questions = questions;// 설문지 문항 리스트
      }
function Question(num, content, type, scale, multiple, detail) {
	this.num = num; //몇번째인가
	this.content = content;// 문항 제목
	this.type = type;// 객관식인지 주관식(객관식이면 숫자 0 주관식이면 숫자 1)
	this.scale = scale;// 객관식일 경우 보기 몇개인지
	this.multiple = multiple//중복대답가능 여부(가능하면1 아니면 0)
	this.detail = detail;//보기 상세설명  상세설명 따로 없으면 그냥 숫자  ex)전혀 보통 아주   
}
function multipleChoice(num, choiceList){
	this.num = num; //몇번째인가
	this.choiceList = choiceList; //뭐뭐 선택했는지, 배열임
}