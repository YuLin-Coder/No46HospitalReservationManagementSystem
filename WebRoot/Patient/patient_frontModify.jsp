<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Patient" %>
<%@ page import="com.chengxusheji.po.Doctor" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的doctorObj信息
    List<Doctor> doctorList = (List<Doctor>)request.getAttribute("doctorList");
    Patient patient = (Patient)request.getAttribute("patient");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改病人信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">病人信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="patientEditForm" id="patientEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="patient_patientId_edit" class="col-md-3 text-right">病人id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="patient_patientId_edit" name="patient.patientId" class="form-control" placeholder="请输入病人id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="patient_doctorObj_doctorNumber_edit" class="col-md-3 text-right">医生:</label>
		  	 <div class="col-md-9">
			    <select id="patient_doctorObj_doctorNumber_edit" name="patient.doctorObj.doctorNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_patientName_edit" class="col-md-3 text-right">病人姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="patient_patientName_edit" name="patient.patientName" class="form-control" placeholder="请输入病人姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="patient_sex_edit" name="patient.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_cardNumber_edit" class="col-md-3 text-right">身份证号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="patient_cardNumber_edit" name="patient.cardNumber" class="form-control" placeholder="请输入身份证号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="patient_telephone_edit" name="patient.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_illnessCase_edit" class="col-md-3 text-right">病人病例:</label>
		  	 <div class="col-md-9">
			    <script name="patient.illnessCase" id="patient_illnessCase_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_addTime_edit" class="col-md-3 text-right">登记时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date patient_addTime_edit col-md-12" data-link-field="patient_addTime_edit">
                    <input class="form-control" id="patient_addTime_edit" name="patient.addTime" size="16" type="text" value="" placeholder="请选择登记时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxPatientModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#patientEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var patient_illnessCase_editor = UE.getEditor('patient_illnessCase_edit'); //病人病例编辑框
var basePath = "<%=basePath%>";
/*弹出修改病人信息界面并初始化数据*/
function patientEdit(patientId) {
  patient_illnessCase_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(patientId);
  });
}
 function ajaxModifyQuery(patientId) {
	$.ajax({
		url :  basePath + "Patient/" + patientId + "/update",
		type : "get",
		dataType: "json",
		success : function (patient, response, status) {
			if (patient) {
				$("#patient_patientId_edit").val(patient.patientId);
				$.ajax({
					url: basePath + "Doctor/listAll",
					type: "get",
					success: function(doctors,response,status) { 
						$("#patient_doctorObj_doctorNumber_edit").empty();
						var html="";
		        		$(doctors).each(function(i,doctor){
		        			html += "<option value='" + doctor.doctorNumber + "'>" + doctor.doctorName + "</option>";
		        		});
		        		$("#patient_doctorObj_doctorNumber_edit").html(html);
		        		$("#patient_doctorObj_doctorNumber_edit").val(patient.doctorObjPri);
					}
				});
				$("#patient_patientName_edit").val(patient.patientName);
				$("#patient_sex_edit").val(patient.sex);
				$("#patient_cardNumber_edit").val(patient.cardNumber);
				$("#patient_telephone_edit").val(patient.telephone);
				patient_illnessCase_editor.setContent(patient.illnessCase, false);
				$("#patient_addTime_edit").val(patient.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交病人信息信息表单给服务器端修改*/
function ajaxPatientModify() {
	$.ajax({
		url :  basePath + "Patient/" + $("#patient_patientId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#patientEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#patientQueryForm").submit();
            }else{
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
    /*登记时间组件*/
    $('.patient_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    patientEdit("<%=request.getParameter("patientId")%>");
 })
 </script> 
</body>
</html>

