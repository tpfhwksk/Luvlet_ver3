package survey;

import java.io.*;
import java.util.*;

public class Survey {
	private int surveyNum;
	private String surveyContent; 
	private int surveyType;
	private int surveyScale;
	private int surveyMultiple;
	private int surveyRow;
	private int surveyCol;
	private String surveyDetail;
	private int surveyAvailable;
	
	public Survey(int num, String content, int type, int scale, int multiple, String detail, int available) {
	     this.surveyNum = num; 
		 this.surveyContent = content;
	      this.surveyType = type;
	      this.surveyScale = scale;
	      this.surveyMultiple = multiple;
	      this.surveyDetail = detail;
	      this.surveyAvailable = available;
	   }

	   public Survey(String content, int type) {
	      this.surveyContent = content;
	      this.surveyType = type;

	   }// 설문지 전체 설명이랑 서술형 문항 위한 생성자
	   
	   public Survey(int num,String content, int type, int row, int col, int multiple, String detail,int available) {
		      this.surveyNum = num;
		      this.surveyContent = content;
		      this.surveyType = type;
		      this.surveyRow = row;
		      this.surveyCol = col;
		      this.surveyMultiple = multiple;
		      this.surveyDetail = detail;
		      this.surveyAvailable = available;
		   } // 그리드 형식의 설문지를 위한 생성자
	
	public Survey() {
		// TODO Auto-generated constructor stub
	}

	public int getSurveyNum() {
		return surveyNum;
	}

	public void setSurveyNum(int surveyNum) {
		this.surveyNum = surveyNum;
	}
	
	 public int getSurveyAvailable() {
		return surveyAvailable;
	}

	public void setSurveyAvailable(int surveyAvailable) {
		this.surveyAvailable = surveyAvailable;
	}
	
	public String getSurveyContent() {
		return surveyContent;
	}
	public void setSurveyContent(String surveyContent) {
		this.surveyContent = surveyContent;
	}
	public int getSurveyType() {
		return surveyType;
	}
	public void setSurveyType(int surveyType) {
		this.surveyType = surveyType;
	}
	public int getSurveyScale() {
		return surveyScale;
	}
	public void setSurveyScale(int surveyScale) {
		this.surveyScale = surveyScale;
	}
	public int getSurveyMultiple() {
		return surveyMultiple;
	}
	public void setSurveyMultiple(int surveyMultiple) {
		this.surveyMultiple = surveyMultiple;
	}
	public String getSurveyDetail() {
		return surveyDetail;
	}
	public void setSurveyDetail(String surveyDetail) {
		this.surveyDetail = surveyDetail;
	}
}


