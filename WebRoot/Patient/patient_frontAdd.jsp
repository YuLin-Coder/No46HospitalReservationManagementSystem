<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Doctor" %>
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
<title>病人信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Patient/frontlist">病人信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#patientAdd" aria-controls="patientAdd" role="tab" data-toggle="tab">添加病人信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="patientList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="patientAdd"> 
				      	<form class="form-horizontal" name="patientAddForm" id="patientAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="patient_doctorObj_doctorNumber" class="col-md-2 text-right">医生:</label>
						  	 <div class="col-md-8">
							    <select id="patient_doctorObj_doctorNumber" name="patient.doctorObj.doctorNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="patient_patientName" class="col-md-2 text-right">病人姓名:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="patient_patientName" name="patient.patientName" class="form-control" placeholder="请输入病人姓名">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="patient_sex" class="col-md-2 text-right">性别:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="patient_sex" name="patient.sex" class="form-control" placeholder="请输入性别">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="patient_cardNumber" class="col-md-2 text-right">身份证号:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="patient_cardNumber" name="patient.cardNumber" class="form-control" placeholder="请输入身份证号">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="patient_telephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="patient_telephone" name="patient.telephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="patient_illnessCase" class="col-md-2 text-right">病人病例:</label>
						  	 <div class="col-md-8">
							    <textarea name="patient.illnessCase" id="patient_illnessCase" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="patient_addTimeDiv" class="col-md-2 text-right">登记时间:</label>
						  	 <div class="col-md-8">
				                <div id="patient_addTimeDiv" class="input-group date patient_addTime col-md-12" data-link-field="patient_addTime">
				                    <input class="form-control" id="patient_addTime" name="patient.addTime" size="16" type="text" value="" placeholder="请选择登记时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxPatientAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#patientAddForm .form-group {margin:10px;}  </style>
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
var patient_illnessCase_editor = UE.getEditor('patient_illnessCase'); //病人病例编辑器
var basePath = "<%=basePath%>";
	//提交添加病人信息信息
	function ajaxPatientAdd() { 
		//提交之前先验证表单
		$("#patientAddForm").data('bootstrapValidator').validate();
		if(!$("#patientAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(patient_illnessCase_editor.getContent() == "") {
			alert('病人病例不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Patient/add",
			dataType : "json" , 
			data: new FormData($("#patientAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#patientAddForm").find("input").val("");
					$("#patientAddForm").find("textarea").val("");
					patient_illnessCase_editor.setContent("");
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
	//验证病人信息添加表单字段
	$('#patientAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"patient.patientName": {
				validators: {
					notEmpty: {
						message: "病人姓名不能为空",
					}
				}
			},
			"patient.sex": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"patient.cardNumber": {
				validators: {
					notEmpty: {
						message: "身份证号不能为空",
					}
				}
			},
			"patient.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"patient.addTime": {
				validators: {
					notEmpty: {
						message: "登记时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化医生下拉框值 
	$.ajax({
		url: basePath + "Doctor/listAll",
		type: "get",
		success: function(doctors,response,status) { 
			$("#patient_doctorObj_doctorNumber").empty();
			var html="";
    		$(doctors).each(function(i,doctor){
    			html += "<option value='" + doctor.doctorNumber + "'>" + doctor.doctorName + "</option>";
    		});
    		$("#patient_doctorObj_doctorNumber").html(html);
    	}
	});
	//登记时间组件
	$('#patient_addTimeDiv').datetimepicker({
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
		$('#patientAddForm').data('bootstrapValidator').updateStatus('patient.addTime', 'NOT_VALIDATED',null).validateField('patient.addTime');
	});
})
</script>
</body>
</html>
