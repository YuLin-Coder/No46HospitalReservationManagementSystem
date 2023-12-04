$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('patient_illnessCase_edit');
	var patient_illnessCase_edit = UE.getEditor('patient_illnessCase_edit'); //病人病例编辑器
	patient_illnessCase_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Patient/" + $("#patient_patientId_edit").val() + "/update",
		type : "get",
		data : {
			//patientId : $("#patient_patientId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (patient, response, status) {
			$.messager.progress("close");
			if (patient) { 
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
				patient_illnessCase_edit.setContent(patient.illnessCase);
				$("#patient_addTime_edit").datetimebox({
					value: patient.addTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#patientModifyButton").click(function(){ 
		if ($("#patientEditForm").form("validate")) {
			$("#patientEditForm").form({
			    url:"Patient/" +  $("#patient_patientId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#patientEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
