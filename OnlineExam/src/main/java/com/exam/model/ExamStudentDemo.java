package com.exam.model;

/**
 * 考生Excel文件下载模板类
 * @author zfh14
 *
 */
public class ExamStudentDemo {
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getStudentGrade() {
		return studentGrade;
	}
	public void setStudentGrade(String studentGrade) {
		this.studentGrade = studentGrade;
	}
	public String getStudentClass() {
		return studentClass;
	}
	public void setStudentClass(String studentClass) {
		this.studentClass = studentClass;
	}
	public String getStudentNumb() {
		return studentNumb;
	}
	public void setStudentNumb(String studentNumb) {
		this.studentNumb = studentNumb;
	}
	private String studentName;
	private String studentGrade;
	private String studentClass;
	private String studentNumb;
}
