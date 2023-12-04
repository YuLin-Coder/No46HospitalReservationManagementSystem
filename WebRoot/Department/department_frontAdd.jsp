<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>科室信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Department/frontlist">科室信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#departmentAdd" aria-controls="departmentAdd" role="tab" data-toggle="tab">添加科室信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="departmentList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="departmentAdd"> 
				      	<form class="form-horizontal" name="departmentAddForm" id="departmentAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="department_departmentName" class="col-md-2 text-right">科室名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="department_departmentName" name="department.departmentName" class="form-control" placeholder="请输入科室名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="department_departmentDesc" class="col-md-2 text-right">科室介绍:</label>
						  	 <div class="col-md-8">
							    <textarea name="department.departmentDesc" id="department_departmentDesc" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="department_birthDateDiv" class="col-md-2 text-right">成立日期:</label>
						  	 <div class="col-md-8">
				                <div id="department_birthDateDiv" class="input-group date department_birthDate col-md-12" data-link-field="department_birthDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="department_birthDate" name="department.birthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="department_chargeMan" class="col-md-2 text-right">负责人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="department_chargeMan" name="department.chargeMan" class="form-control" placeholder="请输入负责人">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxDepartmentAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#departmentAddForm .form-group {margin:10px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var department_departmentDesc_editor = UE.getEditor('department_departmentDesc'); //科室介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加科室信息信息
	function ajaxDepartmentAdd() { 
		//提交之前先验证表单
		$("#departmentAddForm").data('bootstrapValidator').validate();
		if(!$("#departmentAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Department/add",
			dataType : "json" , 
			data: new FormData($("#departmentAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#departmentAddForm").find("input").val("");
					$("#departmentAddForm").find("textarea").val("");
					department_departmentDesc_editor.setContent("");
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
	//验证科室信息添加表单字段
	$('#departmentAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"department.departmentName": {
				validators: {
					notEmpty: {
						message: "科室名称不能为空",
					}
				}
			},
			"department.birthDate": {
				validators: {
					notEmpty: {
						message: "成立日期不能为空",
					}
				}
			},
		}
	}); 
	//成立日期组件
	$('#department_birthDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#departmentAddForm').data('bootstrapValidator').updateStatus('department.birthDate', 'NOT_VALIDATED',null).validateField('department.birthDate');
	});
})
</script>
</body>
</html>
