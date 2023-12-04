<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css" />
<div id="department_editDiv">
	<form id="departmentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">科室id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_departmentId_edit" name="department.departmentId" value="<%=request.getParameter("departmentId") %>" style="width:200px" />
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
				<script id="department_departmentDesc_edit" name="department.departmentDesc" type="text/plain"   style="width:750px;height:500px;"></script>

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
		<div class="operation">
			<a id="departmentModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Department/js/department_modify.js"></script> 
