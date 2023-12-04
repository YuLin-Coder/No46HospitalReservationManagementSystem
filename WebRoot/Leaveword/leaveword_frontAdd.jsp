<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>留言添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Leaveword/frontlist">留言列表</a></li>
			    	<li role="presentation" class="active"><a href="#leavewordAdd" aria-controls="leavewordAdd" role="tab" data-toggle="tab">添加留言</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="leavewordList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="leavewordAdd"> 
				      	<form class="form-horizontal" name="leavewordAddForm" id="leavewordAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="leaveword_leaveTitle" class="col-md-2 text-right">留言标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="leaveword_leaveTitle" name="leaveword.leaveTitle" class="form-control" placeholder="请输入留言标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveword_leaveContent" class="col-md-2 text-right">留言内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="leaveword_leaveContent" name="leaveword.leaveContent" rows="8" class="form-control" placeholder="请输入留言内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveword_userObj_user_name" class="col-md-2 text-right">留言人:</label>
						  	 <div class="col-md-8">
							    <select id="leaveword_userObj_user_name" name="leaveword.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveword_leaveTimeDiv" class="col-md-2 text-right">留言时间:</label>
						  	 <div class="col-md-8">
				                <div id="leaveword_leaveTimeDiv" class="input-group date leaveword_leaveTime col-md-12" data-link-field="leaveword_leaveTime">
				                    <input class="form-control" id="leaveword_leaveTime" name="leaveword.leaveTime" size="16" type="text" value="" placeholder="请选择留言时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveword_replyContent" class="col-md-2 text-right">管理回复:</label>
						  	 <div class="col-md-8">
							    <textarea id="leaveword_replyContent" name="leaveword.replyContent" rows="8" class="form-control" placeholder="请输入管理回复"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveword_replyTimeDiv" class="col-md-2 text-right">回复时间:</label>
						  	 <div class="col-md-8">
				                <div id="leaveword_replyTimeDiv" class="input-group date leaveword_replyTime col-md-12" data-link-field="leaveword_replyTime">
				                    <input class="form-control" id="leaveword_replyTime" name="leaveword.replyTime" size="16" type="text" value="" placeholder="请选择回复时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxLeavewordAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#leavewordAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加留言信息
	function ajaxLeavewordAdd() { 
		//提交之前先验证表单
		$("#leavewordAddForm").data('bootstrapValidator').validate();
		if(!$("#leavewordAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Leaveword/add",
			dataType : "json" , 
			data: new FormData($("#leavewordAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#leavewordAddForm").find("input").val("");
					$("#leavewordAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证留言添加表单字段
	$('#leavewordAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"leaveword.leaveTitle": {
				validators: {
					notEmpty: {
						message: "留言标题不能为空",
					}
				}
			},
			"leaveword.leaveContent": {
				validators: {
					notEmpty: {
						message: "留言内容不能为空",
					}
				}
			},
			"leaveword.leaveTime": {
				validators: {
					notEmpty: {
						message: "留言时间不能为空",
					}
				}
			},
			"leaveword.replyTime": {
				validators: {
					notEmpty: {
						message: "回复时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化留言人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#leaveword_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#leaveword_userObj_user_name").html(html);
    	}
	});
	//留言时间组件
	$('#leaveword_leaveTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#leavewordAddForm').data('bootstrapValidator').updateStatus('leaveword.leaveTime', 'NOT_VALIDATED',null).validateField('leaveword.leaveTime');
	});
	//回复时间组件
	$('#leaveword_replyTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#leavewordAddForm').data('bootstrapValidator').updateStatus('leaveword.replyTime', 'NOT_VALIDATED',null).validateField('leaveword.replyTime');
	});
})
</script>
</body>
</html>
