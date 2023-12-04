package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Doctor {
    /*医生工号*/
    @NotEmpty(message="医生工号不能为空")
    private String doctorNumber;
    public String getDoctorNumber(){
        return doctorNumber;
    }
    public void setDoctorNumber(String doctorNumber){
        this.doctorNumber = doctorNumber;
    }

    /*登录密码*/
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*所在科室*/
    private Department departmentObj;
    public Department getDepartmentObj() {
        return departmentObj;
    }
    public void setDepartmentObj(Department departmentObj) {
        this.departmentObj = departmentObj;
    }

    /*医生姓名*/
    @NotEmpty(message="医生姓名不能为空")
    private String doctorName;
    public String getDoctorName() {
        return doctorName;
    }
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*医生照片*/
    private String doctorPhoto;
    public String getDoctorPhoto() {
        return doctorPhoto;
    }
    public void setDoctorPhoto(String doctorPhoto) {
        this.doctorPhoto = doctorPhoto;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*医生职位*/
    @NotEmpty(message="医生职位不能为空")
    private String position;
    public String getPosition() {
        return position;
    }
    public void setPosition(String position) {
        this.position = position;
    }

    /*工作经验*/
    @NotEmpty(message="工作经验不能为空")
    private String experience;
    public String getExperience() {
        return experience;
    }
    public void setExperience(String experience) {
        this.experience = experience;
    }

    /*联系方式*/
    private String contactWay;
    public String getContactWay() {
        return contactWay;
    }
    public void setContactWay(String contactWay) {
        this.contactWay = contactWay;
    }

    /*擅长*/
    private String goodAt;
    public String getGoodAt() {
        return goodAt;
    }
    public void setGoodAt(String goodAt) {
        this.goodAt = goodAt;
    }

    /*医生介绍*/
    @NotEmpty(message="医生介绍不能为空")
    private String doctorDesc;
    public String getDoctorDesc() {
        return doctorDesc;
    }
    public void setDoctorDesc(String doctorDesc) {
        this.doctorDesc = doctorDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDoctor=new JSONObject(); 
		jsonDoctor.accumulate("doctorNumber", this.getDoctorNumber());
		jsonDoctor.accumulate("password", this.getPassword());
		jsonDoctor.accumulate("departmentObj", this.getDepartmentObj().getDepartmentName());
		jsonDoctor.accumulate("departmentObjPri", this.getDepartmentObj().getDepartmentId());
		jsonDoctor.accumulate("doctorName", this.getDoctorName());
		jsonDoctor.accumulate("sex", this.getSex());
		jsonDoctor.accumulate("doctorPhoto", this.getDoctorPhoto());
		jsonDoctor.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonDoctor.accumulate("position", this.getPosition());
		jsonDoctor.accumulate("experience", this.getExperience());
		jsonDoctor.accumulate("contactWay", this.getContactWay());
		jsonDoctor.accumulate("goodAt", this.getGoodAt());
		jsonDoctor.accumulate("doctorDesc", this.getDoctorDesc());
		return jsonDoctor;
    }}