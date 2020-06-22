package com.exam.model;

public class ExamScore {
    private Integer id;

    private String studentNumb;

    private Integer examId;

    private Integer totalScore;

    private Integer totalPoint;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStudentNumb() {
        return studentNumb;
    }

    public void setStudentNumb(String studentNumb) {
        this.studentNumb = studentNumb == null ? null : studentNumb.trim();
    }

    public Integer getExamId() {
        return examId;
    }

    public void setExamId(Integer examId) {
        this.examId = examId;
    }

    public Integer getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Integer totalScore) {
        this.totalScore = totalScore;
    }

    public Integer getTotalPoint() {
        return totalPoint;
    }

    public void setTotalPoint(Integer totalPoint) {
        this.totalPoint = totalPoint;
    }
}