package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Doctor;
import com.chengxusheji.po.Patient;

import com.chengxusheji.mapper.PatientMapper;
@Service
public class PatientService {

	@Resource PatientMapper patientMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加病人信息记录*/
    public void addPatient(Patient patient) throws Exception {
    	patientMapper.addPatient(patient);
    }

    /*按照查询条件分页查询病人信息记录*/
    public ArrayList<Patient> queryPatient(Doctor doctorObj,String patientName,String cardNumber,String telephone,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != doctorObj &&  doctorObj.getDoctorNumber() != null  && !doctorObj.getDoctorNumber().equals(""))  where += " and t_patient.doctorObj='" + doctorObj.getDoctorNumber() + "'";
    	if(!patientName.equals("")) where = where + " and t_patient.patientName like '%" + patientName + "%'";
    	if(!cardNumber.equals("")) where = where + " and t_patient.cardNumber like '%" + cardNumber + "%'";
    	if(!telephone.equals("")) where = where + " and t_patient.telephone like '%" + telephone + "%'";
    	if(!addTime.equals("")) where = where + " and t_patient.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return patientMapper.queryPatient(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Patient> queryPatient(Doctor doctorObj,String patientName,String cardNumber,String telephone,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != doctorObj &&  doctorObj.getDoctorNumber() != null && !doctorObj.getDoctorNumber().equals(""))  where += " and t_patient.doctorObj='" + doctorObj.getDoctorNumber() + "'";
    	if(!patientName.equals("")) where = where + " and t_patient.patientName like '%" + patientName + "%'";
    	if(!cardNumber.equals("")) where = where + " and t_patient.cardNumber like '%" + cardNumber + "%'";
    	if(!telephone.equals("")) where = where + " and t_patient.telephone like '%" + telephone + "%'";
    	if(!addTime.equals("")) where = where + " and t_patient.addTime like '%" + addTime + "%'";
    	return patientMapper.queryPatientList(where);
    }

    /*查询所有病人信息记录*/
    public ArrayList<Patient> queryAllPatient()  throws Exception {
        return patientMapper.queryPatientList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Doctor doctorObj,String patientName,String cardNumber,String telephone,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(null != doctorObj &&  doctorObj.getDoctorNumber() != null && !doctorObj.getDoctorNumber().equals(""))  where += " and t_patient.doctorObj='" + doctorObj.getDoctorNumber() + "'";
    	if(!patientName.equals("")) where = where + " and t_patient.patientName like '%" + patientName + "%'";
    	if(!cardNumber.equals("")) where = where + " and t_patient.cardNumber like '%" + cardNumber + "%'";
    	if(!telephone.equals("")) where = where + " and t_patient.telephone like '%" + telephone + "%'";
    	if(!addTime.equals("")) where = where + " and t_patient.addTime like '%" + addTime + "%'";
        recordNumber = patientMapper.queryPatientCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取病人信息记录*/
    public Patient getPatient(int patientId) throws Exception  {
        Patient patient = patientMapper.getPatient(patientId);
        return patient;
    }

    /*更新病人信息记录*/
    public void updatePatient(Patient patient) throws Exception {
        patientMapper.updatePatient(patient);
    }

    /*删除一条病人信息记录*/
    public void deletePatient (int patientId) throws Exception {
        patientMapper.deletePatient(patientId);
    }

    /*删除多条病人信息信息*/
    public int deletePatients (String patientIds) throws Exception {
    	String _patientIds[] = patientIds.split(",");
    	for(String _patientId: _patientIds) {
    		patientMapper.deletePatient(Integer.parseInt(_patientId));
    	}
    	return _patientIds.length;
    }
}
