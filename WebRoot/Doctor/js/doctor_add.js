$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('doctor_doctorDesc');
	var doctor_doctorDesc_editor = UE.getEditor('doctor_doctorDesc'); //医生介绍编辑框
	$("#doctor_doctorNumber").validatebox({
		required : true, 
		missingMessage : '请输入医生工号',
	});

	$("#doctor_departmentObj_departmentId").combobox({
	    url:'Department/listAll',
	    valueField: "departmentId",
	    textField: "departmentName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#doctor_departmentObj_departmentId").combobox("getData"); 
            if (data.length > 0) {
                $("#doctor_departmentObj_departmentId").combobox("select", data[0].departmentId);
            }
        }
	});
	$("#doctor_doctorName").validatebox({
		required : true, 
		missingMessage : '请输入医生姓名',
	});

	$("#doctor_sex").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#doctor_birthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#doctor_position").validatebox({
		required : true, 
		missingMessage : '请输入医生职位',
	});

	$("#doctor_experience").validatebox({
		required : true, 
		missingMessage : '请输入工作经验',
	});

	//单击添加按钮
	$("#doctorAddButton").click(function () {
		if(doctor_doctorDesc_editor.getContent() == "") {
			alert("请输入医生介绍");
			return;
		}
		//验证表单 
		if(!$("#doctorAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#doctorAddForm").form({
			    url:"Doctor/add",
			    onSubmit: function(){
					if($("#doctorAddForm").form("validate"))  { 
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
                        $("#doctorAddForm").form("clear");
                        doctor_doctorDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#doctorAddForm").submit();
		}
	});

	//单击清空按钮
	$("#doctorClearButton").click(function () { 
		$("#doctorAddForm").form("clear"); 
	});
});
