package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class OrderInfo {
    /*预约id*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*预约用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*预约医生*/
    private Doctor doctorObj;
    public Doctor getDoctorObj() {
        return doctorObj;
    }
    public void setDoctorObj(Doctor doctorObj) {
        this.doctorObj = doctorObj;
    }

    /*预约日期*/
    @NotEmpty(message="预约日期不能为空")
    private String orderDate;
    public String getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    /*时段*/
    @NotEmpty(message="时段不能为空")
    private String timeInterval;
    public String getTimeInterval() {
        return timeInterval;
    }
    public void setTimeInterval(String timeInterval) {
        this.timeInterval = timeInterval;
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

    /*下单时间*/
    @NotEmpty(message="下单时间不能为空")
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    /*处理状态*/
    @NotEmpty(message="处理状态不能为空")
    private String checkState;
    public String getCheckState() {
        return checkState;
    }
    public void setCheckState(String checkState) {
        this.checkState = checkState;
    }

    /*医生回复*/
    @NotEmpty(message="医生回复不能为空")
    private String replyContent;
    public String getReplyContent() {
        return replyContent;
    }
    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOrderInfo=new JSONObject(); 
		jsonOrderInfo.accumulate("orderId", this.getOrderId());
		jsonOrderInfo.accumulate("userObj", this.getUserObj().getName());
		jsonOrderInfo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonOrderInfo.accumulate("doctorObj", this.getDoctorObj().getDoctorName());
		jsonOrderInfo.accumulate("doctorObjPri", this.getDoctorObj().getDoctorNumber());
		jsonOrderInfo.accumulate("orderDate", this.getOrderDate().length()>19?this.getOrderDate().substring(0,19):this.getOrderDate());
		jsonOrderInfo.accumulate("timeInterval", this.getTimeInterval());
		jsonOrderInfo.accumulate("telephone", this.getTelephone());
		jsonOrderInfo.accumulate("orderTime", this.getOrderTime().length()>19?this.getOrderTime().substring(0,19):this.getOrderTime());
		jsonOrderInfo.accumulate("checkState", this.getCheckState());
		jsonOrderInfo.accumulate("replyContent", this.getReplyContent());
		return jsonOrderInfo;
    }}