package com.chengxusheji.mapper;


import com.chengxusheji.po.Admin;

public interface AdminMapper {
 
	public Admin findAdminByUserName(String username) throws Exception;
	
	public void changePassword(Admin admin) throws Exception;
	
	
	
}
