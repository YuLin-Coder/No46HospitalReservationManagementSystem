<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Doctor" %>
<%@ page import="com.chengxusheji.po.Department" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的departmentObj信息
    List<Department> departmentList = (List<Department>)request.getAttribute("departmentList");
    Doctor doctor = (Doctor)request.getAttribute("doctor");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改医生信息信息</TITLE>
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
  		<li class="active">医生信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="doctorEditForm" id="doctorEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="doctor_doctorNumber_edit" class="col-md-3 text-right">医生工号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="doctor_doctorNumber_edit" name="doctor.doctorNumber" class="form-control" placeholder="请输入医生工号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="doctor_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_password_edit" name="doctor.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_departmentObj_departmentId_edit" class="col-md-3 text-right">所在科室:</label>
		  	 <div class="col-md-9">
			    <select id="doctor_departmentObj_departmentId_edit" name="doctor.departmentObj.departmentId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_doctorName_edit" class="col-md-3 text-right">医生姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_doctorName_edit" name="doctor.doctorName" class="form-control" placeholder="请输入医生姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_sex_edit" name="doctor.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_doctorPhoto_edit" class="col-md-3 text-right">医生照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="doctor_doctorPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="doctor_doctorPhoto" name="doctor.doctorPhoto"/>
			    <input id="doctorPhotoFile" name="doctorPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date doctor_birthDate_edit col-md-12" data-link-field="doctor_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="doctor_birthDate_edit" name="doctor.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_position_edit" class="col-md-3 text-right">医生职位:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_position_edit" name="doctor.position" class="form-control" placeholder="请输入医生职位">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_experience_edit" class="col-md-3 text-right">工作经验:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_experience_edit" name="doctor.experience" class="form-control" placeholder="请输入工作经验">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_contactWay_edit" class="col-md-3 text-right">联系方式:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_contactWay_edit" name="doctor.contactWay" class="form-control" placeholder="请输入联系方式">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_goodAt_edit" class="col-md-3 text-right">擅长:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_goodAt_edit" name="doctor.goodAt" class="form-control" placeholder="请输入擅长">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_doctorDesc_edit" class="col-md-3 text-right">医生介绍:</label>
		  	 <div class="col-md-9">
			    <script name="doctor.doctorDesc" id="doctor_doctorDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxDoctorModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#doctorEditForm .form-group {margin-bottom:5px;}  </style>
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
var doctor_doctorDesc_editor = UE.getEditor('doctor_doctorDesc_edit'); //医生介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改医生信息界面并初始化数据*/
function doctorEdit(doctorNumber) {
  doctor_doctorDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(doctorNumber);
  });
}
 function ajaxModifyQuery(doctorNumber) {
	$.ajax({
		url :  basePath + "Doctor/" + doctorNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (doctor, response, status) {
			if (doctor) {
				$("#doctor_doctorNumber_edit").val(doctor.doctorNumber);
				$("#doctor_password_edit").val(doctor.password);
				$.ajax({
					url: basePath + "Department/listAll",
					type: "get",
					success: function(departments,response,status) { 
						$("#doctor_departmentObj_departmentId_edit").empty();
						var html="";
		        		$(departments).each(function(i,department){
		        			html += "<option value='" + department.departmentId + "'>" + department.departmentName + "</option>";
		        		});
		        		$("#doctor_departmentObj_departmentId_edit").html(html);
		        		$("#doctor_departmentObj_departmentId_edit").val(doctor.departmentObjPri);
					}
				});
				$("#doctor_doctorName_edit").val(doctor.doctorName);
				$("#doctor_sex_edit").val(doctor.sex);
				$("#doctor_doctorPhoto").val(doctor.doctorPhoto);
				$("#doctor_doctorPhotoImg").attr("src", basePath +　doctor.doctorPhoto);
				$("#doctor_birthDate_edit").val(doctor.birthDate);
				$("#doctor_position_edit").val(doctor.position);
				$("#doctor_experience_edit").val(doctor.experience);
				$("#doctor_contactWay_edit").val(doctor.contactWay);
				$("#doctor_goodAt_edit").val(doctor.goodAt);
				doctor_doctorDesc_editor.setContent(doctor.doctorDesc, false);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交医生信息信息表单给服务器端修改*/
function ajaxDoctorModify() {
	$.ajax({
		url :  basePath + "Doctor/" + $("#doctor_doctorNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#doctorEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#doctorQueryForm").submit();
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
    /*出生日期组件*/
    $('.doctor_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    doctorEdit("<%=request.getParameter("doctorNumber")%>");
 })
 </script> 
</body>
</html>

