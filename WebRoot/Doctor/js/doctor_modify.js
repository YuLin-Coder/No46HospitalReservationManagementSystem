$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('doctor_doctorDesc_edit');
	var doctor_doctorDesc_edit = UE.getEditor('doctor_doctorDesc_edit'); //医生介绍编辑器
	doctor_doctorDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Doctor/" + $("#doctor_doctorNumber_edit").val() + "/update",
		type : "get",
		data : {
			//doctorNumber : $("#doctor_doctorNumber_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (doctor, response, status) {
			$.messager.progress("close");
			if (doctor) { 
				$("#doctor_doctorNumber_edit").val(doctor.doctorNumber);
				$("#doctor_doctorNumber_edit").validatebox({
					required : true,
					missingMessage : "请输入医生工号",
					editable: false
				});
				$("#doctor_password_edit").val(doctor.password);
				$("#doctor_departmentObj_departmentId_edit").combobox({
					url:"Department/listAll",
					valueField:"departmentId",
					textField:"departmentName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#doctor_departmentObj_departmentId_edit").combobox("select", doctor.departmentObjPri);
						//var data = $("#doctor_departmentObj_departmentId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#doctor_departmentObj_departmentId_edit").combobox("select", data[0].departmentId);
						//}
					}
				});
				$("#doctor_doctorName_edit").val(doctor.doctorName);
				$("#doctor_doctorName_edit").validatebox({
					required : true,
					missingMessage : "请输入医生姓名",
				});
				$("#doctor_sex_edit").val(doctor.sex);
				$("#doctor_sex_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#doctor_doctorPhoto").val(doctor.doctorPhoto);
				$("#doctor_doctorPhotoImg").attr("src", doctor.doctorPhoto);
				$("#doctor_birthDate_edit").datebox({
					value: doctor.birthDate,
					required: true,
					showSeconds: true,
				});
				$("#doctor_position_edit").val(doctor.position);
				$("#doctor_position_edit").validatebox({
					required : true,
					missingMessage : "请输入医生职位",
				});
				$("#doctor_experience_edit").val(doctor.experience);
				$("#doctor_experience_edit").validatebox({
					required : true,
					missingMessage : "请输入工作经验",
				});
				$("#doctor_contactWay_edit").val(doctor.contactWay);
				$("#doctor_goodAt_edit").val(doctor.goodAt);
				doctor_doctorDesc_edit.setContent(doctor.doctorDesc);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#doctorModifyButton").click(function(){ 
		if ($("#doctorEditForm").form("validate")) {
			$("#doctorEditForm").form({
			    url:"Doctor/" +  $("#doctor_doctorNumber_edit").val() + "/update",
			    onSubmit: function(){
					if($("#doctorEditForm").form("validate"))  {
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
			$("#doctorEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
