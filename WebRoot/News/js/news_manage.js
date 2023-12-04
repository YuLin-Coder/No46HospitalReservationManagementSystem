var news_manage_tool = null; 
$(function () { 
	initNewsManageTool(); //建立News管理对象
	news_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#news_manage").datagrid({
		url : 'News/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "newsId",
		sortOrder : "desc",
		toolbar : "#news_manage_tool",
		columns : [[
			{
				field : "newsId",
				title : "新闻id",
				width : 70,
			},
			{
				field : "newsTitle",
				title : "新闻标题",
				width : 140,
			},
			{
				field : "newsPhoto",
				title : "新闻图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "newsDate",
				title : "新闻日期",
				width : 140,
			},
			{
				field : "newsFrom",
				title : "新闻来源",
				width : 140,
			},
		]],
	});

	$("#newsEditDiv").dialog({
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
				if ($("#newsEditForm").form("validate")) {
					//验证表单 
					if(!$("#newsEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#newsEditForm").form({
						    url:"News/" + $("#news_newsId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#newsEditForm").form("validate"))  {
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
			                        $("#newsEditDiv").dialog("close");
			                        news_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#newsEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#newsEditDiv").dialog("close");
				$("#newsEditForm").form("reset"); 
			},
		}],
	});
});

function initNewsManageTool() {
	news_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#news_manage").datagrid("reload");
		},
		redo : function () {
			$("#news_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#news_manage").datagrid("options").queryParams;
			queryParams["newsTitle"] = $("#newsTitle").val();
			queryParams["newsDate"] = $("#newsDate").datebox("getValue"); 
			$("#news_manage").datagrid("options").queryParams=queryParams; 
			$("#news_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#newsQueryForm").form({
			    url:"News/OutToExcel",
			});
			//提交表单
			$("#newsQueryForm").submit();
		},
		remove : function () {
			var rows = $("#news_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var newsIds = [];
						for (var i = 0; i < rows.length; i ++) {
							newsIds.push(rows[i].newsId);
						}
						$.ajax({
							type : "POST",
							url : "News/deletes",
							data : {
								newsIds : newsIds.join(","),
							},
							beforeSend : function () {
								$("#news_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#news_manage").datagrid("loaded");
									$("#news_manage").datagrid("load");
									$("#news_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#news_manage").datagrid("loaded");
									$("#news_manage").datagrid("load");
									$("#news_manage").datagrid("unselectAll");
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
			var rows = $("#news_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "News/" + rows[0].newsId +  "/update",
					type : "get",
					data : {
						//newsId : rows[0].newsId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (news, response, status) {
						$.messager.progress("close");
						if (news) { 
							$("#newsEditDiv").dialog("open");
							$("#news_newsId_edit").val(news.newsId);
							$("#news_newsId_edit").validatebox({
								required : true,
								missingMessage : "请输入新闻id",
								editable: false
							});
							$("#news_newsTitle_edit").val(news.newsTitle);
							$("#news_newsTitle_edit").validatebox({
								required : true,
								missingMessage : "请输入新闻标题",
							});
							$("#news_newsPhoto").val(news.newsPhoto);
							$("#news_newsPhotoImg").attr("src", news.newsPhoto);
							news_newsContent_editor.setContent(news.newsContent, false);
							$("#news_newsDate_edit").datebox({
								value: news.newsDate,
							    required: true,
							    showSeconds: true,
							});
							$("#news_newsFrom_edit").val(news.newsFrom);
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
