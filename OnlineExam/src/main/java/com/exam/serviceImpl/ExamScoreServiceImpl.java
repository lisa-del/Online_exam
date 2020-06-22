package com.exam.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exam.dao.IExamScoreDao;
import com.exam.model.ExamScore;
import com.exam.model.ExamScoreExample;
import com.exam.service.IExamScoreService;

@Service
public class ExamScoreServiceImpl implements IExamScoreService{

	@Autowired
	IExamScoreDao examScoreDao;
	
	@Override
	public int insertExamScore(ExamScore examScore) {
		// TODO Auto-generated method stub
		return examScoreDao.insert(examScore);
	}

	@Override
	public ExamScore getExamScore(int examId, String studentNumb) {
		// TODO Auto-generated method stub
		ExamScoreExample example = new ExamScoreExample();
		ExamScoreExample.Criteria criteria = example.createCriteria();
		if(examId>0 && studentNumb!=null) {
			criteria.andExamIdEqualTo(examId);
			criteria.andStudentNumbEqualTo(studentNumb);
		}
		List<ExamScore> list = examScoreDao.selectByExample(example);
		if(list.size()>0) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public List<ExamScore> getExamScoreList(String studentNumb) {
		// TODO Auto-generated method stub
		ExamScoreExample example = new ExamScoreExample();
		ExamScoreExample.Criteria criteria = example.createCriteria();
		if(studentNumb!=null) {
			criteria.andStudentNumbEqualTo(studentNumb);
		}
		return examScoreDao.selectByExample(example);
	}

	@Override
	public List<ExamScore> getExamScoreByExamId(int examId) {
		// TODO Auto-generated method stub
		ExamScoreExample example = new ExamScoreExample();
		ExamScoreExample.Criteria criteria = example.createCriteria();
		if(examId>0) {
			criteria.andExamIdEqualTo(examId);
		}
		return examScoreDao.selectByExample(example);
	}

}
