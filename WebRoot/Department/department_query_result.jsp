<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css" /> 

<div id="department_manage"></div>
<div id="department_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="department_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="department_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="department_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="department_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="department_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="departmentQueryForm" method="post">
			科室名称：<input type="text" class="textbox" id="departmentName" name="departmentName" style="width:110px" />
			成立日期：<input type="text" id="birthDate" name="birthDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="department_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="departmentEditDiv">
	<form id="departmentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">科室id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_departmentId_edit" name="department.departmentId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">科室名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_departmentName_edit" name="department.departmentName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">科室介绍:</span>
			<span class="inputControl">
				<script name="department.departmentDesc" id="department_departmentDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_birthDate_edit" name="department.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">负责人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_chargeMan_edit" name="department.chargeMan" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var department_departmentDesc_editor = UE.getEditor('department_departmentDesc_edit'); //科室介绍编辑器
</script>
<script type="text/javascript" src="Department/js/department_manage.js"></script> 
