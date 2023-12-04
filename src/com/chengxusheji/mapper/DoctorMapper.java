package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Doctor;

public interface DoctorMapper {
	/*添加医生信息信息*/
	public void addDoctor(Doctor doctor) throws Exception;

	/*按照查询条件分页查询医生信息记录*/
	public ArrayList<Doctor> queryDoctor(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有医生信息记录*/
	public ArrayList<Doctor> queryDoctorList(@Param("where") String where) throws Exception;

	/*按照查询条件的医生信息记录数*/
	public int queryDoctorCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条医生信息记录*/
	public Doctor getDoctor(String doctorNumber) throws Exception;

	/*更新医生信息记录*/
	public void updateDoctor(Doctor doctor) throws Exception;

	/*删除医生信息记录*/
	public void deleteDoctor(String doctorNumber) throws Exception;

}
