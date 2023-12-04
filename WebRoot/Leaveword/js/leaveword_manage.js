var leaveword_manage_tool = null; 
$(function () { 
	initLeavewordManageTool(); //建立Leaveword管理对象
	leaveword_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#leaveword_manage").datagrid({
		url : 'Leaveword/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "leaveWordId",
		sortOrder : "desc",
		toolbar : "#leaveword_manage_tool",
		columns : [[
			{
				field : "leaveWordId",
				title : "留言id",
				width : 70,
			},
			{
				field : "leaveTitle",
				title : "留言标题",
				width : 140,
			},
			{
				field : "userObj",
				title : "留言人",
				width : 140,
			},
			{
				field : "leaveTime",
				title : "留言时间",
				width : 140,
			},
			{
				field : "replyContent",
				title : "管理回复",
				width : 140,
			},
			{
				field : "replyTime",
				title : "回复时间",
				width : 140,
			},
		]],
	});

	$("#leavewordEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#leavewordEditForm").form("validate")) {
					//验证表单 
					if(!$("#leavewordEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#leavewordEditForm").form({
						    url:"Leaveword/" + $("#leaveword_leaveWordId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#leavewordEditForm").form("validate"))  {
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
			                        $("#leavewordEditDiv").dialog("close");
			                        leaveword_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#leavewordEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#leavewordEditDiv").dialog("close");
				$("#leavewordEditForm").form("reset"); 
			},
		}],
	});
});

function initLeavewordManageTool() {
	leaveword_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#leaveword_manage").datagrid("reload");
		},
		redo : function () {
			$("#leaveword_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#leaveword_manage").datagrid("options").queryParams;
			queryParams["leaveTitle"] = $("#leaveTitle").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["leaveTime"] = $("#leaveTime").datebox("getValue"); 
			$("#leaveword_manage").datagrid("options").queryParams=queryParams; 
			$("#leaveword_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#leavewordQueryForm").form({
			    url:"Leaveword/OutToExcel",
			});
			//提交表单
			$("#leavewordQueryForm").submit();
		},
		remove : function () {
			var rows = $("#leaveword_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var leaveWordIds = [];
						for (var i = 0; i < rows.length; i ++) {
							leaveWordIds.push(rows[i].leaveWordId);
						}
						$.ajax({
							type : "POST",
							url : "Leaveword/deletes",
							data : {
								leaveWordIds : leaveWordIds.join(","),
							},
							beforeSend : function () {
								$("#leaveword_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#leaveword_manage").datagrid("loaded");
									$("#leaveword_manage").datagrid("load");
									$("#leaveword_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#leaveword_manage").datagrid("loaded");
									$("#leaveword_manage").datagrid("load");
									$("#leaveword_manage").datagrid("unselectAll");
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
			var rows = $("#leaveword_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Leaveword/" + rows[0].leaveWordId +  "/update",
					type : "get",
					data : {
						//leaveWordId : rows[0].leaveWordId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (leaveword, response, status) {
						$.messager.progress("close");
						if (leaveword) { 
							$("#leavewordEditDiv").dialog("open");
							$("#leaveword_leaveWordId_edit").val(leaveword.leaveWordId);
							$("#leaveword_leaveWordId_edit").validatebox({
								required : true,
								missingMessage : "请输入留言id",
								editable: false
							});
							$("#leaveword_leaveTitle_edit").val(leaveword.leaveTitle);
							$("#leaveword_leaveTitle_edit").validatebox({
								required : true,
								missingMessage : "请输入留言标题",
							});
							$("#leaveword_leaveContent_edit").val(leaveword.leaveContent);
							$("#leaveword_leaveContent_edit").validatebox({
								required : true,
								missingMessage : "请输入留言内容",
							});
							$("#leaveword_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#leaveword_userObj_user_name_edit").combobox("select", leaveword.userObjPri);
									//var data = $("#leaveword_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#leaveword_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#leaveword_leaveTime_edit").datetimebox({
								value: leaveword.leaveTime,
							    required: true,
							    showSeconds: true,
							});
							$("#leaveword_replyContent_edit").val(leaveword.replyContent);
							$("#leaveword_replyTime_edit").datetimebox({
								value: leaveword.replyTime,
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
