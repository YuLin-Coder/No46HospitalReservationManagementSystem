$(function () {
	$.ajax({
		url : "OrderInfo/" + $("#orderInfo_orderId_edit").val() + "/update",
		type : "get",
		data : {
			//orderId : $("#orderInfo_orderId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (orderInfo, response, status) {
			$.messager.progress("close");
			if (orderInfo) { 
				$("#orderInfo_orderId_edit").val(orderInfo.orderId);
				$("#orderInfo_orderId_edit").validatebox({
					required : true,
					missingMessage : "请输入预约id",
					editable: false
				});
				$("#orderInfo_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#orderInfo_userObj_user_name_edit").combobox("select", orderInfo.userObjPri);
						//var data = $("#orderInfo_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#orderInfo_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#orderInfo_doctorObj_doctorNumber_edit").combobox({
					url:"Doctor/listAll",
					valueField:"doctorNumber",
					textField:"doctorName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#orderInfo_doctorObj_doctorNumber_edit").combobox("select", orderInfo.doctorObjPri);
						//var data = $("#orderInfo_doctorObj_doctorNumber_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#orderInfo_doctorObj_doctorNumber_edit").combobox("select", data[0].doctorNumber);
						//}
					}
				});
				$("#orderInfo_orderDate_edit").datebox({
					value: orderInfo.orderDate,
					required: true,
					showSeconds: true,
				});
				$("#orderInfo_timeInterval_edit").val(orderInfo.timeInterval);
				$("#orderInfo_timeInterval_edit").validatebox({
					required : true,
					missingMessage : "请输入时段",
				});
				$("#orderInfo_telephone_edit").val(orderInfo.telephone);
				$("#orderInfo_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#orderInfo_orderTime_edit").datetimebox({
					value: orderInfo.orderTime,
					required: true,
					showSeconds: true,
				});
				$("#orderInfo_checkState_edit").val(orderInfo.checkState);
				$("#orderInfo_checkState_edit").validatebox({
					required : true,
					missingMessage : "请输入处理状态",
				});
				$("#orderInfo_replyContent_edit").val(orderInfo.replyContent);
				$("#orderInfo_replyContent_edit").validatebox({
					required : true,
					missingMessage : "请输入医生回复",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#orderInfoModifyButton").click(function(){ 
		if ($("#orderInfoEditForm").form("validate")) {
			$("#orderInfoEditForm").form({
			    url:"OrderInfo/" +  $("#orderInfo_orderId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#orderInfoEditForm").form("validate"))  {
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
			$("#orderInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
