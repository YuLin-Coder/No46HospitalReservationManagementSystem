package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;

import com.chengxusheji.mapper.UserInfoMapper;
@Service
public class UserInfoService {

	@Resource UserInfoMapper userInfoMapper;
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

    /*添加用户记录*/
    public void addUserInfo(UserInfo userInfo) throws Exception {
    	userInfoMapper.addUserInfo(userInfo);
    }

    /*按照查询条件分页查询用户记录*/
    public ArrayList<UserInfo> queryUserInfo(String user_name,String name,String birthDate,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!user_name.equals("")) where = where + " and t_userInfo.user_name like '%" + user_name + "%'";
    	if(!name.equals("")) where = where + " and t_userInfo.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_userInfo.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_userInfo.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return userInfoMapper.queryUserInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<UserInfo> queryUserInfo(String user_name,String name,String birthDate,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!user_name.equals("")) where = where + " and t_userInfo.user_name like '%" + user_name + "%'";
    	if(!name.equals("")) where = where + " and t_userInfo.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_userInfo.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_userInfo.telephone like '%" + telephone + "%'";
    	return userInfoMapper.queryUserInfoList(where);
    }

    /*查询所有用户记录*/
    public ArrayList<UserInfo> queryAllUserInfo()  throws Exception {
        return userInfoMapper.queryUserInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String user_name,String name,String birthDate,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!user_name.equals("")) where = where + " and t_userInfo.user_name like '%" + user_name + "%'";
    	if(!name.equals("")) where = where + " and t_userInfo.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_userInfo.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_userInfo.telephone like '%" + telephone + "%'";
        recordNumber = userInfoMapper.queryUserInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取用户记录*/
    public UserInfo getUserInfo(String user_name) throws Exception  {
        UserInfo userInfo = userInfoMapper.getUserInfo(user_name);
        return userInfo;
    }

    /*更新用户记录*/
    public void updateUserInfo(UserInfo userInfo) throws Exception {
        userInfoMapper.updateUserInfo(userInfo);
    }

    /*删除一条用户记录*/
    public void deleteUserInfo (String user_name) throws Exception {
        userInfoMapper.deleteUserInfo(user_name);
    }

    /*删除多条用户信息*/
    public int deleteUserInfos (String user_names) throws Exception {
    	String _user_names[] = user_names.split(",");
    	for(String _user_name: _user_names) {
    		userInfoMapper.deleteUserInfo(_user_name);
    	}
    	return _user_names.length;
    }
}
