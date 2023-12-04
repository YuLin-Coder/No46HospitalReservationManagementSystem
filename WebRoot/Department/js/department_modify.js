$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('department_departmentDesc_edit');
	var department_departmentDesc_edit = UE.getEditor('department_departmentDesc_edit'); //科室介绍编辑器
	department_departmentDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Department/" + $("#department_departmentId_edit").val() + "/update",
		type : "get",
		data : {
			//departmentId : $("#department_departmentId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (department, response, status) {
			$.messager.progress("close");
			if (department) { 
				$("#department_departmentId_edit").val(department.departmentId);
				$("#department_departmentId_edit").validatebox({
					required : true,
					missingMessage : "请输入科室id",
					editable: false
				});
				$("#department_departmentName_edit").val(department.departmentName);
				$("#department_departmentName_edit").validatebox({
					required : true,
					missingMessage : "请输入科室名称",
				});
				department_departmentDesc_edit.setContent(department.departmentDesc);
				$("#department_birthDate_edit").datebox({
					value: department.birthDate,
					required: true,
					showSeconds: true,
				});
				$("#department_chargeMan_edit").val(department.chargeMan);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#departmentModifyButton").click(function(){ 
		if ($("#departmentEditForm").form("validate")) {
			$("#departmentEditForm").form({
			    url:"Department/" +  $("#department_departmentId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#departmentEditForm").form("validate"))  {
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
			$("#departmentEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
