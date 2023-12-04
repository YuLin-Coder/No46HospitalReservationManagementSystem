$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('news_newsContent');
	var news_newsContent_editor = UE.getEditor('news_newsContent'); //新闻内容编辑框
	$("#news_newsTitle").validatebox({
		required : true, 
		missingMessage : '请输入新闻标题',
	});

	$("#news_newsDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#newsAddButton").click(function () {
		if(news_newsContent_editor.getContent() == "") {
			alert("请输入新闻内容");
			return;
		}
		//验证表单 
		if(!$("#newsAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#newsAddForm").form({
			    url:"News/add",
			    onSubmit: function(){
					if($("#newsAddForm").form("validate"))  { 
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
                        $("#newsAddForm").form("clear");
                        news_newsContent_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#newsAddForm").submit();
		}
	});

	//单击清空按钮
	$("#newsClearButton").click(function () { 
		$("#newsAddForm").form("clear"); 
	});
});
