package survey;

import java.io.*;
import java.util.*;

public class Survey {
	private String surveyContent; 
	private int surveyType;
	private int surveyScale;
	private int surveyMultiple;
	private String surveyDetail;
	
	 public Survey(String content, int type, int scale, int multiple, String detail) {
	      this.surveyContent = content;
	      this.surveyType = type;
	      this.surveyScale = scale;
	      this.surveyMultiple = multiple;
	      this.surveyDetail = detail;
	   }

	   public Survey(String content, int type) {
	      this.surveyContent = content;
	      this.surveyType = type;

	   }// 설문지 전체 설명이랑 서술형 문항 위한 생성자
	
	
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


