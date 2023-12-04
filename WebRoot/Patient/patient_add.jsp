<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/patient.css" />
<div id="patientAddDiv">
	<form id="patientAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">医生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_doctorObj_doctorNumber" name="patient.doctorObj.doctorNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">病人姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_patientName" name="patient.patientName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_sex" name="patient.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">身份证号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_cardNumber" name="patient.cardNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_telephone" name="patient.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">病人病例:</span>
			<span class="inputControl">
				<script name="patient.illnessCase" id="patient_illnessCase" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">登记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_addTime" name="patient.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="patientAddButton" class="easyui-linkbutton">添加</a>
			<a id="patientClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Patient/js/patient_add.js"></script> 
