package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Patient {
    /*病人id*/
    private Integer patientId;
    public Integer getPatientId(){
        return patientId;
    }
    public void setPatientId(Integer patientId){
        this.patientId = patientId;
    }

    /*医生*/
    private Doctor doctorObj;
    public Doctor getDoctorObj() {
        return doctorObj;
    }
    public void setDoctorObj(Doctor doctorObj) {
        this.doctorObj = doctorObj;
    }

    /*病人姓名*/
    @NotEmpty(message="病人姓名不能为空")
    private String patientName;
    public String getPatientName() {
        return patientName;
    }
    public void setPatientName(String patientName) {
        this.patientName = patientName;
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

    /*身份证号*/
    @NotEmpty(message="身份证号不能为空")
    private String cardNumber;
    public String getCardNumber() {
        return cardNumber;
    }
    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*病人病例*/
    @NotEmpty(message="病人病例不能为空")
    private String illnessCase;
    public String getIllnessCase() {
        return illnessCase;
    }
    public void setIllnessCase(String illnessCase) {
        this.illnessCase = illnessCase;
    }

    /*登记时间*/
    @NotEmpty(message="登记时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPatient=new JSONObject(); 
		jsonPatient.accumulate("patientId", this.getPatientId());
		jsonPatient.accumulate("doctorObj", this.getDoctorObj().getDoctorName());
		jsonPatient.accumulate("doctorObjPri", this.getDoctorObj().getDoctorNumber());
		jsonPatient.accumulate("patientName", this.getPatientName());
		jsonPatient.accumulate("sex", this.getSex());
		jsonPatient.accumulate("cardNumber", this.getCardNumber());
		jsonPatient.accumulate("telephone", this.getTelephone());
		jsonPatient.accumulate("illnessCase", this.getIllnessCase());
		jsonPatient.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonPatient;
    }}