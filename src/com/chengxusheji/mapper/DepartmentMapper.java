package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Department;

public interface DepartmentMapper {
	/*添加科室信息信息*/
	public void addDepartment(Department department) throws Exception;

	/*按照查询条件分页查询科室信息记录*/
	public ArrayList<Department> queryDepartment(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有科室信息记录*/
	public ArrayList<Department> queryDepartmentList(@Param("where") String where) throws Exception;

	/*按照查询条件的科室信息记录数*/
	public int queryDepartmentCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条科室信息记录*/
	public Department getDepartment(int departmentId) throws Exception;

	/*更新科室信息记录*/
	public void updateDepartment(Department department) throws Exception;

	/*删除科室信息记录*/
	public void deleteDepartment(int departmentId) throws Exception;

}
