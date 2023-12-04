<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userInfo.css" /> 

<div id="userInfo_manage"></div>
<div id="userInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="userInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="userInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="userInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="userInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="userInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="userInfoQueryForm" method="post">
			用户名：<input type="text" class="textbox" id="user_name" name="user_name" style="width:110px" />
			姓名：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			出生日期：<input type="text" id="birthDate" name="birthDate" class="easyui-datebox" editable="false" style="width:100px">
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="userInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="userInfoEditDiv">
	<form id="userInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_user_name_edit" name="userInfo.user_name" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_password_edit" name="userInfo.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_name_edit" name="userInfo.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_gender_edit" name="userInfo.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_birthDate_edit" name="userInfo.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">用户照片:</span>
			<span class="inputControl">
				<img id="userInfo_userPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="userInfo_userPhoto" name="userInfo.userPhoto"/>
				<input id="userPhotoFile" name="userPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_telephone_edit" name="userInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_email_edit" name="userInfo.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_address_edit" name="userInfo.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">注册时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_regTime_edit" name="userInfo.regTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="UserInfo/js/userInfo_manage.js"></script> 
