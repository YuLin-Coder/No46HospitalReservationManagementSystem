<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/patient.css" />
<div id="patient_editDiv">
	<form id="patientEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">病人id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_patientId_edit" name="patient.patientId" value="<%=request.getParameter("patientId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">医生:</span>
			<span class="inputControl">
				<input class="textbox"  id="patient_doctorObj_doctorNumber_edit" name="patient.doctorObj.doctorNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">病人姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_patientName_edit" name="patient.patientName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_sex_edit" name="patient.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">身份证号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_cardNumber_edit" name="patient.cardNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_telephone_edit" name="patient.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">病人病例:</span>
			<span class="inputControl">
				<script id="patient_illnessCase_edit" name="patient.illnessCase" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">登记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_addTime_edit" name="patient.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="patientModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Patient/js/patient_modify.js"></script> 
