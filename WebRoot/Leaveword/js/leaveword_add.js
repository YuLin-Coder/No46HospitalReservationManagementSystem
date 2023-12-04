$(function () {
	$("#leaveword_leaveTitle").validatebox({
		required : true, 
		missingMessage : '请输入留言标题',
	});

	$("#leaveword_leaveContent").validatebox({
		required : true, 
		missingMessage : '请输入留言内容',
	});

	$("#leaveword_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#leaveword_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#leaveword_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#leaveword_leaveTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#leaveword_replyTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#leavewordAddButton").click(function () {
		//验证表单 
		if(!$("#leavewordAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#leavewordAddForm").form({
			    url:"Leaveword/add",
			    onSubmit: function(){
					if($("#leavewordAddForm").form("validate"))  { 
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
                        $("#leavewordAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#leavewordAddForm").submit();
		}
	});

	//单击清空按钮
	$("#leavewordClearButton").click(function () { 
		$("#leavewordAddForm").form("clear"); 
	});
});
