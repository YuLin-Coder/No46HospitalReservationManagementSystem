<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Department" %>
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
<title>医生信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Doctor/frontlist">医生信息管理</a></li>
  			<li class="active">添加医生信息</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="doctorAddForm" id="doctorAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="doctor_doctorNumber" class="col-md-2 text-right">医生工号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="doctor_doctorNumber" name="doctor.doctorNumber" class="form-control" placeholder="请输入医生工号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="doctor_password" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="doctor_password" name="doctor.password" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_departmentObj_departmentId" class="col-md-2 text-right">所在科室:</label>
				  	 <div class="col-md-8">
					    <select id="doctor_departmentObj_departmentId" name="doctor.departmentObj.departmentId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_doctorName" class="col-md-2 text-right">医生姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="doctor_doctorName" name="doctor.doctorName" class="form-control" placeholder="请输入医生姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_sex" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="doctor_sex" name="doctor.sex" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_doctorPhoto" class="col-md-2 text-right">医生照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="doctor_doctorPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="doctor_doctorPhoto" name="doctor.doctorPhoto"/>
					    <input id="doctorPhotoFile" name="doctorPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_birthDateDiv" class="col-md-2 text-right">出生日期:</label>
				  	 <div class="col-md-8">
		                <div id="doctor_birthDateDiv" class="input-group date doctor_birthDate col-md-12" data-link-field="doctor_birthDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="doctor_birthDate" name="doctor.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_position" class="col-md-2 text-right">医生职位:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="doctor_position" name="doctor.position" class="form-control" placeholder="请输入医生职位">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_experience" class="col-md-2 text-right">工作经验:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="doctor_experience" name="doctor.experience" class="form-control" placeholder="请输入工作经验">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_contactWay" class="col-md-2 text-right">联系方式:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="doctor_contactWay" name="doctor.contactWay" class="form-control" placeholder="请输入联系方式">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_goodAt" class="col-md-2 text-right">擅长:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="doctor_goodAt" name="doctor.goodAt" class="form-control" placeholder="请输入擅长">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="doctor_doctorDesc" class="col-md-2 text-right">医生介绍:</label>
				  	 <div class="col-md-8">
							    <textarea name="doctor.doctorDesc" id="doctor_doctorDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxDoctorAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#doctorAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
var doctor_doctorDesc_editor = UE.getEditor('doctor_doctorDesc'); //医生介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加医生信息信息
	function ajaxDoctorAdd() { 
		//提交之前先验证表单
		$("#doctorAddForm").data('bootstrapValidator').validate();
		if(!$("#doctorAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(doctor_doctorDesc_editor.getContent() == "") {
			alert('医生介绍不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Doctor/add",
			dataType : "json" , 
			data: new FormData($("#doctorAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#doctorAddForm").find("input").val("");
					$("#doctorAddForm").find("textarea").val("");
					doctor_doctorDesc_editor.setContent("");
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
	//验证医生信息添加表单字段
	$('#doctorAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"doctor.doctorNumber": {
				validators: {
					notEmpty: {
						message: "医生工号不能为空",
					}
				}
			},
			"doctor.doctorName": {
				validators: {
					notEmpty: {
						message: "医生姓名不能为空",
					}
				}
			},
			"doctor.sex": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"doctor.birthDate": {
				validators: {
					notEmpty: {
						message: "出生日期不能为空",
					}
				}
			},
			"doctor.position": {
				validators: {
					notEmpty: {
						message: "医生职位不能为空",
					}
				}
			},
			"doctor.experience": {
				validators: {
					notEmpty: {
						message: "工作经验不能为空",
					}
				}
			},
		}
	}); 
	//初始化所在科室下拉框值 
	$.ajax({
		url: basePath + "Department/listAll",
		type: "get",
		success: function(departments,response,status) { 
			$("#doctor_departmentObj_departmentId").empty();
			var html="";
    		$(departments).each(function(i,department){
    			html += "<option value='" + department.departmentId + "'>" + department.departmentName + "</option>";
    		});
    		$("#doctor_departmentObj_departmentId").html(html);
    	}
	});
	//出生日期组件
	$('#doctor_birthDateDiv').datetimepicker({
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
		$('#doctorAddForm').data('bootstrapValidator').updateStatus('doctor.birthDate', 'NOT_VALIDATED',null).validateField('doctor.birthDate');
	});
})
</script>
</body>
</html>
