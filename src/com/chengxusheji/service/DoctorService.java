package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Department;
import com.chengxusheji.po.Doctor;

import com.chengxusheji.mapper.DoctorMapper;
@Service
public class DoctorService {

	@Resource DoctorMapper doctorMapper;
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

    /*添加医生信息记录*/
    public void addDoctor(Doctor doctor) throws Exception {
    	doctorMapper.addDoctor(doctor);
    }

    /*按照查询条件分页查询医生信息记录*/
    public ArrayList<Doctor> queryDoctor(String doctorNumber,Department departmentObj,String doctorName,String birthDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!doctorNumber.equals("")) where = where + " and t_doctor.doctorNumber like '%" + doctorNumber + "%'";
    	if(null != departmentObj && departmentObj.getDepartmentId()!= null && departmentObj.getDepartmentId()!= 0)  where += " and t_doctor.departmentObj=" + departmentObj.getDepartmentId();
    	if(!doctorName.equals("")) where = where + " and t_doctor.doctorName like '%" + doctorName + "%'";
    	if(!birthDate.equals("")) where = where + " and t_doctor.birthDate like '%" + birthDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return doctorMapper.queryDoctor(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Doctor> queryDoctor(String doctorNumber,Department departmentObj,String doctorName,String birthDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!doctorNumber.equals("")) where = where + " and t_doctor.doctorNumber like '%" + doctorNumber + "%'";
    	if(null != departmentObj && departmentObj.getDepartmentId()!= null && departmentObj.getDepartmentId()!= 0)  where += " and t_doctor.departmentObj=" + departmentObj.getDepartmentId();
    	if(!doctorName.equals("")) where = where + " and t_doctor.doctorName like '%" + doctorName + "%'";
    	if(!birthDate.equals("")) where = where + " and t_doctor.birthDate like '%" + birthDate + "%'";
    	return doctorMapper.queryDoctorList(where);
    }

    /*查询所有医生信息记录*/
    public ArrayList<Doctor> queryAllDoctor()  throws Exception {
        return doctorMapper.queryDoctorList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String doctorNumber,Department departmentObj,String doctorName,String birthDate) throws Exception {
     	String where = "where 1=1";
    	if(!doctorNumber.equals("")) where = where + " and t_doctor.doctorNumber like '%" + doctorNumber + "%'";
    	if(null != departmentObj && departmentObj.getDepartmentId()!= null && departmentObj.getDepartmentId()!= 0)  where += " and t_doctor.departmentObj=" + departmentObj.getDepartmentId();
    	if(!doctorName.equals("")) where = where + " and t_doctor.doctorName like '%" + doctorName + "%'";
    	if(!birthDate.equals("")) where = where + " and t_doctor.birthDate like '%" + birthDate + "%'";
        recordNumber = doctorMapper.queryDoctorCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取医生信息记录*/
    public Doctor getDoctor(String doctorNumber) throws Exception  {
        Doctor doctor = doctorMapper.getDoctor(doctorNumber);
        return doctor;
    }

    /*更新医生信息记录*/
    public void updateDoctor(Doctor doctor) throws Exception {
        doctorMapper.updateDoctor(doctor);
    }

    /*删除一条医生信息记录*/
    public void deleteDoctor (String doctorNumber) throws Exception {
        doctorMapper.deleteDoctor(doctorNumber);
    }

    /*删除多条医生信息信息*/
    public int deleteDoctors (String doctorNumbers) throws Exception {
    	String _doctorNumbers[] = doctorNumbers.split(",");
    	for(String _doctorNumber: _doctorNumbers) {
    		doctorMapper.deleteDoctor(_doctorNumber);
    	}
    	return _doctorNumbers.length;
    }
}
