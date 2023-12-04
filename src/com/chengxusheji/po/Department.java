package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Department {
    /*科室id*/
    private Integer departmentId;
    public Integer getDepartmentId(){
        return departmentId;
    }
    public void setDepartmentId(Integer departmentId){
        this.departmentId = departmentId;
    }

    /*科室名称*/
    @NotEmpty(message="科室名称不能为空")
    private String departmentName;
    public String getDepartmentName() {
        return departmentName;
    }
    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    /*科室介绍*/
    private String departmentDesc;
    public String getDepartmentDesc() {
        return departmentDesc;
    }
    public void setDepartmentDesc(String departmentDesc) {
        this.departmentDesc = departmentDesc;
    }

    /*成立日期*/
    @NotEmpty(message="成立日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*负责人*/
    private String chargeMan;
    public String getChargeMan() {
        return chargeMan;
    }
    public void setChargeMan(String chargeMan) {
        this.chargeMan = chargeMan;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDepartment=new JSONObject(); 
		jsonDepartment.accumulate("departmentId", this.getDepartmentId());
		jsonDepartment.accumulate("departmentName", this.getDepartmentName());
		jsonDepartment.accumulate("departmentDesc", this.getDepartmentDesc());
		jsonDepartment.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonDepartment.accumulate("chargeMan", this.getChargeMan());
		return jsonDepartment;
    }}