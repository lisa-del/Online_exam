package com.exam.service;

import java.util.List;

import com.exam.model.ExamHistory;

public interface IExamHistoryService {

	public void saveExamHistoryList(List<ExamHistory> examHistoryList);

	public List<ExamHistory> getExamHistoryByPara(int examId, String studentNumb);

	public List<ExamHistory> getExamHistoryByExamId(int examId);
	
}
