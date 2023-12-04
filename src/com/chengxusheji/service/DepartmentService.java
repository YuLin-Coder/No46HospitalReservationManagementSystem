package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Department;

import com.chengxusheji.mapper.DepartmentMapper;
@Service
public class DepartmentService {

	@Resource DepartmentMapper departmentMapper;
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

    /*添加科室信息记录*/
    public void addDepartment(Department department) throws Exception {
    	departmentMapper.addDepartment(department);
    }

    /*按照查询条件分页查询科室信息记录*/
    public ArrayList<Department> queryDepartment(String departmentName,String birthDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!departmentName.equals("")) where = where + " and t_department.departmentName like '%" + departmentName + "%'";
    	if(!birthDate.equals("")) where = where + " and t_department.birthDate like '%" + birthDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return departmentMapper.queryDepartment(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Department> queryDepartment(String departmentName,String birthDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!departmentName.equals("")) where = where + " and t_department.departmentName like '%" + departmentName + "%'";
    	if(!birthDate.equals("")) where = where + " and t_department.birthDate like '%" + birthDate + "%'";
    	return departmentMapper.queryDepartmentList(where);
    }

    /*查询所有科室信息记录*/
    public ArrayList<Department> queryAllDepartment()  throws Exception {
        return departmentMapper.queryDepartmentList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String departmentName,String birthDate) throws Exception {
     	String where = "where 1=1";
    	if(!departmentName.equals("")) where = where + " and t_department.departmentName like '%" + departmentName + "%'";
    	if(!birthDate.equals("")) where = where + " and t_department.birthDate like '%" + birthDate + "%'";
        recordNumber = departmentMapper.queryDepartmentCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取科室信息记录*/
    public Department getDepartment(int departmentId) throws Exception  {
        Department department = departmentMapper.getDepartment(departmentId);
        return department;
    }

    /*更新科室信息记录*/
    public void updateDepartment(Department department) throws Exception {
        departmentMapper.updateDepartment(department);
    }

    /*删除一条科室信息记录*/
    public void deleteDepartment (int departmentId) throws Exception {
        departmentMapper.deleteDepartment(departmentId);
    }

    /*删除多条科室信息信息*/
    public int deleteDepartments (String departmentIds) throws Exception {
    	String _departmentIds[] = departmentIds.split(",");
    	for(String _departmentId: _departmentIds) {
    		departmentMapper.deleteDepartment(Integer.parseInt(_departmentId));
    	}
    	return _departmentIds.length;
    }
}
