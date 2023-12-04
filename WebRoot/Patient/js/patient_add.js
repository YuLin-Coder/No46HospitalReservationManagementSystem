$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('patient_illnessCase');
	var patient_illnessCase_editor = UE.getEditor('patient_illnessCase'); //病人病例编辑框
	$("#patient_doctorObj_doctorNumber").combobox({
	    url:'Doctor/listAll',
	    valueField: "doctorNumber",
	    textField: "doctorName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#patient_doctorObj_doctorNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#patient_doctorObj_doctorNumber").combobox("select", data[0].doctorNumber);
            }
        }
	});
	$("#patient_patientName").validatebox({
		required : true, 
		missingMessage : '请输入病人姓名',
	});

	$("#patient_sex").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#patient_cardNumber").validatebox({
		required : true, 
		missingMessage : '请输入身份证号',
	});

	$("#patient_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#patient_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#patientAddButton").click(function () {
		if(patient_illnessCase_editor.getContent() == "") {
			alert("请输入病人病例");
			return;
		}
		//验证表单 
		if(!$("#patientAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#patientAddForm").form({
			    url:"Patient/add",
			    onSubmit: function(){
					if($("#patientAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#patientAddForm").form("clear");
                        patient_illnessCase_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#patientAddForm").submit();
		}
	});

	//单击清空按钮
	$("#patientClearButton").click(function () { 
		$("#patientAddForm").form("clear"); 
	});
});
