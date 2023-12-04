<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/doctor.css" /> 

<div id="doctor_manage"></div>
<div id="doctor_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="doctor_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="doctor_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="doctor_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="doctor_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="doctor_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="doctorQueryForm" method="post">
			医生工号：<input type="text" class="textbox" id="doctorNumber" name="doctorNumber" style="width:110px" />
			所在科室：<input class="textbox" type="text" id="departmentObj_departmentId_query" name="departmentObj.departmentId" style="width: auto"/>
			医生姓名：<input type="text" class="textbox" id="doctorName" name="doctorName" style="width:110px" />
			出生日期：<input type="text" id="birthDate" name="birthDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doctor_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="doctorEditDiv">
	<form id="doctorEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">医生工号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_doctorNumber_edit" name="doctor.doctorNumber" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_password_edit" name="doctor.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在科室:</span>
			<span class="inputControl">
				<input class="textbox"  id="doctor_departmentObj_departmentId_edit" name="doctor.departmentObj.departmentId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">医生姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_doctorName_edit" name="doctor.doctorName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_sex_edit" name="doctor.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">医生照片:</span>
			<span class="inputControl">
				<img id="doctor_doctorPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="doctor_doctorPhoto" name="doctor.doctorPhoto"/>
				<input id="doctorPhotoFile" name="doctorPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_birthDate_edit" name="doctor.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">医生职位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_position_edit" name="doctor.position" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作经验:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_experience_edit" name="doctor.experience" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系方式:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_contactWay_edit" name="doctor.contactWay" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">擅长:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_goodAt_edit" name="doctor.goodAt" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">医生介绍:</span>
			<span class="inputControl">
				<script name="doctor.doctorDesc" id="doctor_doctorDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var doctor_doctorDesc_editor = UE.getEditor('doctor_doctorDesc_edit'); //医生介绍编辑器
</script>
<script type="text/javascript" src="Doctor/js/doctor_manage.js"></script> 
