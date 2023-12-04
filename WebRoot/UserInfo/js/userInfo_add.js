$(function () {
	$("#userInfo_user_name").validatebox({
		required : true, 
		missingMessage : '请输入用户名',
	});

	$("#userInfo_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#userInfo_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#userInfo_gender").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#userInfo_birthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#userInfo_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#userInfo_email").validatebox({
		required : true, 
		missingMessage : '请输入邮箱',
	});

	$("#userInfo_regTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#userInfoAddButton").click(function () {
		//验证表单 
		if(!$("#userInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#userInfoAddForm").form({
			    url:"UserInfo/add",
			    onSubmit: function(){
					if($("#userInfoAddForm").form("validate"))  { 
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
                        $("#userInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#userInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#userInfoClearButton").click(function () { 
		$("#userInfoAddForm").form("clear"); 
	});
});
