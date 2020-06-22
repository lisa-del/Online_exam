package com.exam.model;

public class ExamHistory {
    private Integer id;

    private Integer examId;

    private String studentNumb;

    private Integer questionId;

    private Integer score;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getExamId() {
        return examId;
    }

    public void setExamId(Integer examId) {
        this.examId = examId;
    }

    public String getStudentNumb() {
        return studentNumb;
    }

    public void setStudentNumb(String studentNumb) {
        this.studentNumb = studentNumb == null ? null : studentNumb.trim();
    }

    public Integer getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
}