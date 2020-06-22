package com.exam.service;

import java.util.List;

import com.exam.model.ExamScore;

public interface IExamScoreService {
	public int insertExamScore(ExamScore examScore);
	
	public ExamScore getExamScore(int examId,String studentNumb);
	
	public List<ExamScore> getExamScoreList(String studentNumb);

	public List<ExamScore> getExamScoreByExamId(int examId);

}
