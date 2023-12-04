<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/doctor.css" />
<div id="doctor_editDiv">
	<form id="doctorEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">医生工号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_doctorNumber_edit" name="doctor.doctorNumber" value="<%=request.getParameter("doctorNumber") %>" style="width:200px" />
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
				<script id="doctor_doctorDesc_edit" name="doctor.doctorDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div class="operation">
			<a id="doctorModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Doctor/js/doctor_modify.js"></script> 
