<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/doctor.css" />
<div id="doctorAddDiv">
	<form id="doctorAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">医生工号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_doctorNumber" name="doctor.doctorNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_password" name="doctor.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在科室:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_departmentObj_departmentId" name="doctor.departmentObj.departmentId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">医生姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_doctorName" name="doctor.doctorName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_sex" name="doctor.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">医生照片:</span>
			<span class="inputControl">
				<input id="doctorPhotoFile" name="doctorPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_birthDate" name="doctor.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">医生职位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_position" name="doctor.position" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作经验:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_experience" name="doctor.experience" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系方式:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_contactWay" name="doctor.contactWay" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">擅长:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="doctor_goodAt" name="doctor.goodAt" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">医生介绍:</span>
			<span class="inputControl">
				<script name="doctor.doctorDesc" id="doctor_doctorDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div class="operation">
			<a id="doctorAddButton" class="easyui-linkbutton">添加</a>
			<a id="doctorClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Doctor/js/doctor_add.js"></script> 
