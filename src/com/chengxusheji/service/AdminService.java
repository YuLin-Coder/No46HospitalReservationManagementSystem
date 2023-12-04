package com.chengxusheji.service;

import javax.annotation.Resource;

 
import org.springframework.stereotype.Service;

import com.chengxusheji.mapper.AdminMapper; 
import com.chengxusheji.po.Admin;

@Service
public class AdminService {
	@Resource AdminMapper adminMapper;

	/*保存业务逻辑错误信息字段*/
	private String errMessage;
	public String getErrMessage() { return this.errMessage; }
	
	/*验证用户登录*/
	public boolean checkLogin(Admin admin) throws Exception { 
		Admin db_admin = (Admin) adminMapper.findAdminByUserName(admin.getUsername());
		if(db_admin == null) { 
			this.errMessage = " 账号不存在 ";
			System.out.print(this.errMessage);
			return false;
		} else if( !db_admin.getPassword().equals(admin.getPassword())) {
			this.errMessage = " 密码不正确! ";
			System.out.print(this.errMessage);
			return false;
		}
		
		return true;
	}
	

	/*修改用户登录密码*/
	public void changePassword(String username, String newPassword) throws Exception {  
		Admin admin = new Admin();
		admin.setUsername(username);
		admin.setPassword(newPassword);
		adminMapper.changePassword(admin);  
	}
	
	/*根据用户名获取管理员对象*/
	public Admin findAdminByUserName(String username) throws Exception {
		Admin db_admin = null;
		db_admin = adminMapper.findAdminByUserName(username);
		return db_admin;
	}
}
