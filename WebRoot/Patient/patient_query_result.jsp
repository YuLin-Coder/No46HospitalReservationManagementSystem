<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/patient.css" /> 

<div id="patient_manage"></div>
<div id="patient_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="patient_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="patient_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="patient_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="patient_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="patient_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="patientQueryForm" method="post">
			医生：<input class="textbox" type="text" id="doctorObj_doctorNumber_query" name="doctorObj.doctorNumber" style="width: auto"/>
			病人姓名：<input type="text" class="textbox" id="patientName" name="patientName" style="width:110px" />
			身份证号：<input type="text" class="textbox" id="cardNumber" name="cardNumber" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			登记时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="patient_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="patientEditDiv">
	<form id="patientEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">病人id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_patientId_edit" name="patient.patientId" style="width:200px" />
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
				<script name="patient.illnessCase" id="patient_illnessCase_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">登记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="patient_addTime_edit" name="patient.addTime" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var patient_illnessCase_editor = UE.getEditor('patient_illnessCase_edit'); //病人病例编辑器
</script>
<script type="text/javascript" src="Patient/js/patient_manage.js"></script> 
