var patient_manage_tool = null; 
$(function () { 
	initPatientManageTool(); //建立Patient管理对象
	patient_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#patient_manage").datagrid({
		url : 'Patient/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "patientId",
		sortOrder : "desc",
		toolbar : "#patient_manage_tool",
		columns : [[
			{
				field : "patientId",
				title : "病人id",
				width : 70,
			},
			{
				field : "doctorObj",
				title : "医生",
				width : 140,
			},
			{
				field : "patientName",
				title : "病人姓名",
				width : 140,
			},
			{
				field : "sex",
				title : "性别",
				width : 140,
			},
			{
				field : "cardNumber",
				title : "身份证号",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
			{
				field : "addTime",
				title : "登记时间",
				width : 140,
			},
		]],
	});

	$("#patientEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#patientEditForm").form("validate")) {
					//验证表单 
					if(!$("#patientEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#patientEditForm").form({
						    url:"Patient/" + $("#patient_patientId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#patientEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#patientEditDiv").dialog("close");
			                        patient_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#patientEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#patientEditDiv").dialog("close");
				$("#patientEditForm").form("reset"); 
			},
		}],
	});
});

function initPatientManageTool() {
	patient_manage_tool = {
		init: function() {
			$.ajax({
				url : "Doctor/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#doctorObj_doctorNumber_query").combobox({ 
					    valueField:"doctorNumber",
					    textField:"doctorName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{doctorNumber:"",doctorName:"不限制"});
					$("#doctorObj_doctorNumber_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#patient_manage").datagrid("reload");
		},
		redo : function () {
			$("#patient_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#patient_manage").datagrid("options").queryParams;
			queryParams["doctorObj.doctorNumber"] = $("#doctorObj_doctorNumber_query").combobox("getValue");
			queryParams["patientName"] = $("#patientName").val();
			queryParams["cardNumber"] = $("#cardNumber").val();
			queryParams["telephone"] = $("#telephone").val();
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			$("#patient_manage").datagrid("options").queryParams=queryParams; 
			$("#patient_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#patientQueryForm").form({
			    url:"Patient/OutToExcel",
			});
			//提交表单
			$("#patientQueryForm").submit();
		},
		remove : function () {
			var rows = $("#patient_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var patientIds = [];
						for (var i = 0; i < rows.length; i ++) {
							patientIds.push(rows[i].patientId);
						}
						$.ajax({
							type : "POST",
							url : "Patient/deletes",
							data : {
								patientIds : patientIds.join(","),
							},
							beforeSend : function () {
								$("#patient_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#patient_manage").datagrid("loaded");
									$("#patient_manage").datagrid("load");
									$("#patient_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#patient_manage").datagrid("loaded");
									$("#patient_manage").datagrid("load");
									$("#patient_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#patient_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Patient/" + rows[0].patientId +  "/update",
					type : "get",
					data : {
						//patientId : rows[0].patientId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (patient, response, status) {
						$.messager.progress("close");
						if (patient) { 
							$("#patientEditDiv").dialog("open");
							$("#patient_patientId_edit").val(patient.patientId);
							$("#patient_patientId_edit").validatebox({
								required : true,
								missingMessage : "请输入病人id",
								editable: false
							});
							$("#patient_doctorObj_doctorNumber_edit").combobox({
								url:"Doctor/listAll",
							    valueField:"doctorNumber",
							    textField:"doctorName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#patient_doctorObj_doctorNumber_edit").combobox("select", patient.doctorObjPri);
									//var data = $("#patient_doctorObj_doctorNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#patient_doctorObj_doctorNumber_edit").combobox("select", data[0].doctorNumber);
						            //}
								}
							});
							$("#patient_patientName_edit").val(patient.patientName);
							$("#patient_patientName_edit").validatebox({
								required : true,
								missingMessage : "请输入病人姓名",
							});
							$("#patient_sex_edit").val(patient.sex);
							$("#patient_sex_edit").validatebox({
								required : true,
								missingMessage : "请输入性别",
							});
							$("#patient_cardNumber_edit").val(patient.cardNumber);
							$("#patient_cardNumber_edit").validatebox({
								required : true,
								missingMessage : "请输入身份证号",
							});
							$("#patient_telephone_edit").val(patient.telephone);
							$("#patient_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							patient_illnessCase_editor.setContent(patient.illnessCase, false);
							$("#patient_addTime_edit").datetimebox({
								value: patient.addTime,
							    required: true,
							    showSeconds: true,
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
