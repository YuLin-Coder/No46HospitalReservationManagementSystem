package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Patient;

public interface PatientMapper {
	/*添加病人信息信息*/
	public void addPatient(Patient patient) throws Exception;

	/*按照查询条件分页查询病人信息记录*/
	public ArrayList<Patient> queryPatient(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有病人信息记录*/
	public ArrayList<Patient> queryPatientList(@Param("where") String where) throws Exception;

	/*按照查询条件的病人信息记录数*/
	public int queryPatientCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条病人信息记录*/
	public Patient getPatient(int patientId) throws Exception;

	/*更新病人信息记录*/
	public void updatePatient(Patient patient) throws Exception;

	/*删除病人信息记录*/
	public void deletePatient(int patientId) throws Exception;

}
